class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_beta_login

  protected
  	def require_beta_login
  		authenticate_or_request_with_http_basic do |username, password|
        username == "go" && password == "fish"
      end
  	end

  private
  	def admin_user
  		redirect_to root_path unless current_user.admin?
  	end

    def instructor
      redirect_to root_path unless current_user.instructor?
    end
end
