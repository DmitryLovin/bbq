class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user, only: %i[ facebook github ]

  rescue_from HiddenEmailError, with: :hidden_email

  def facebook
    complete("Facebook")
  end

  def github
    complete("Github")
  end

  private

  def complete(provider)
    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider)
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        "devise.omniauth_callbacks.failure",
        kind: provider,
        reason: "authentication error"
      )

      redirect_to root_path
    end
  end

  def hidden_email(e)
    flash[:error] = e.message

    redirect_to new_user_registration_path
  end

  def set_user
    @user = User.find_for_oauth(request.env["omniauth.auth"])
  end
end
