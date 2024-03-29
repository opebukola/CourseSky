class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def all
    # raise request.env["omniauth.auth"].to_yaml #to see errors with generated has
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
        flash.notice = "Signed in!"
        sign_in_and_redirect user
    else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url
    end
  end
  alias_method :facebook, :all
end



