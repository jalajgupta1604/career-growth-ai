class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    is_new_user = !User.exists?(provider: request.env["omniauth.auth"].provider, google_uid: request.env["omniauth.auth"].uid)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      UserMailer.welcome(@user).deliver_later if is_new_user
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
