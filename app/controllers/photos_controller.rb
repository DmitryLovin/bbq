class PhotosController < ApplicationController
  before_action :set_event, only: %i[ create destroy ]
  before_action :set_photo, only: %i[ destroy ]

  def create
    @new_photo = @event.photos.build(photo_params)
    @new_photo.user = current_user

    if @new_photo.save
      notify_subscribers(@new_photo)

      redirect_to @event, notice: I18n.t("controllers.photos.created")
    else
      render "events/show", alert: I18n.t("controllers.photos.error")
    end
  end

  def destroy
    message = { notice: I18n.t("controllers.photos.destroyed") }

    if (current_user_can_edit?(@photo))
      @photo.destroy
    else
      message = { alert: I18n.t("controllers.photos.error") }
    end

    redirect_to @event, message
  end

  private

  def notify_subscribers(photo)
    all_emails = (photo.event.subscriptions.map(&:user_email) + [photo.event.user.email] - [photo.user.email]).uniq

    all_emails.each do |mail|
      MailJob.perform_later(photo, mail)
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end
end
