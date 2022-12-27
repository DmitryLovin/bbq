class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials[:mailjet_default_from]
  layout "mailer"
end
