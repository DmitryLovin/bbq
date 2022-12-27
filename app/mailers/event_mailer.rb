class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "#{I18n.t("mailer.subject.newsub")} #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "#{I18n.t("mailer.subject.newcomment")} @ #{event.title}"
  end

  def photo(event, photo, email)
    @event = event
    @photo = photo

    mail to: email, subject: I18n.t("mailer.subject.newphoto")
  end
end
