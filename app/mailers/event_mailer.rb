class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    @greeting = "Hi"

    mail to: event.user.email, subject: "#{I18n.t("mailer.subject.newsub")} #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    @greeting = "Hi"

    mail to: email, subject: "#{I18n.t("mailer.subject.newcomment")} @ #{event.title}"
  end
end
