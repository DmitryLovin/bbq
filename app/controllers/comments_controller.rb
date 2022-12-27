class CommentsController < ApplicationController
  before_action :set_event, only: %i[ create destroy ]
  before_action :set_comment, only: %i[ destroy ]

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      notify_subscribers(@new_comment)

      redirect_to @event, notice: I18n.t("controllers.comments.created")
    else
      render "events/show", alert: I18n.t("controllers.comments.error")
    end
  end

  def destroy
    message = { notice: I18n.t("controllers.comments.destroyed") }

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = { alert: I18n.t("controllers.comments.error") }
    end

    redirect_to @event, message
  end

  private

  def notify_subscribers(comment)
    all_emails = (comment.event.subscriptions.map(&:user_email) + [comment.event.user.email]).uniq
    all_emails -= [comment.user&.email]

    all_emails.each do |mail|
      EventMailer.comment(comment, mail).deliver_later
    end
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end
end
