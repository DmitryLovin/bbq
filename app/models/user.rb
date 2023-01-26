class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :github]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def self.find_for_oauth(access_token)
    provider = access_token.provider
    email = access_token.info.email

    raise HiddenEmailError.new(provider) if email.nil?

    user = where(email: email).first

    return user if user.present?

    id = access_token.extra.raw_info.id
    url = case provider
          when "facebook" then "https://facebook.com/#{id}"
          when "github" then access_token.info.urls.GitHub
          else "#{provider}/#{id}"
          end

    name = access_token.info.name || access_token.info.nickname
    avatar_url = access_token.info.image

    where(url: url, provider: provider).first_or_create! do |user|
      user.name = name
      user.remote_avatar_url = avatar_url
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
  end

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  def set_name
    self.name = "User##{rand(777)}" if self.name.blank?
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
