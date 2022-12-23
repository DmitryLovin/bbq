class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validate :self_subscription
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def self_subscription
    if user.present? && event.user == user
      errors.add(:user, I18n.t("activerecord.validates.subscriptions.self_subscription"));
    end
  end
end
