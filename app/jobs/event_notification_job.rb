class EventNotificationJob < ApplicationJob
  queue_as :default

  def perform(object, mail = nil)
    if mail.nil?
      all_emails = (object.event.subscriptions.map(&:user_email) + [object.event.user.email]).uniq
      all_emails -= [object.user&.email]
      all_emails.each do |email|
        EventMailer.try(object.class.to_s.downcase, object, email).deliver_now
      end
    else
      EventMailer.try(object.class.to_s.downcase, object, mail).deliver_now
    end
  end
end
