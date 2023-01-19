class SubscriptionsController < ApplicationController
  before_action :set_event, only: %i[ create destroy ]
  before_action :set_subscription, only: %i[ destroy ]

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    authorize(@new_subscription)

    if @new_subscription.save
      EventMailer.subscription(@new_subscription).deliver_later

      redirect_to @event, notice: I18n.t("controllers.subscriptions.created")
    else
      render "events/show", alert: I18n.t("controllers.subscriptions.error_sub")
    end
  end

  def destroy
    authorize(@subscription)

    @subscription.destroy

    redirect_to @event, notice: I18n.t("controllers.subscriptions.destroyed")
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
