class MailJob < ApplicationJob
  queue_as :default

  def perform(object, mail = nil)
    EventMailer.try(object.class.to_s.downcase, object, mail).deliver_now
  end
end
