class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  rescue_from HiddenEmailError, with: :hidden_email

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    complete("Facebook")
  end

  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])

    complete("Github")
  end

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

  private

  def hidden_email(e)
    flash[:error] = e.message

    redirect_to new_user_registration_path
  end
end
