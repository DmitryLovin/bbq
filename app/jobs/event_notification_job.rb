class EventNotificationJob < ApplicationJob
  queue_as :default

  def perform(object, mail = nil)
    return EventMailer.public_send(object.class.model_name.singular, object, mail).deliver_now until mail.nil?

    all_emails = (object.event.subscriptions.map(&:user_email) + [object.event.user.email]).uniq
    all_emails -= [object.user&.email]
    all_emails.each do |email|
      EventMailer.public_send(object.class.model_name.singular, object, email).deliver_now
    end
  end
end
