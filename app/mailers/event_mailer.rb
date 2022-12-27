class EventMailer < ApplicationMailer

  def subscription(subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = subscription.event

    mail to: @event.user.email, subject: "#{I18n.t("mailer.subject.newsub")} #{event.title}"
  end

  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: "#{I18n.t("mailer.subject.newcomment")} @ #{@event.title}"
  end

  def photo(photo, email)
    @event = photo.event
    @photo = photo

    mail to: email, subject: I18n.t("mailer.subject.newphoto")
  end
end
