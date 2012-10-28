class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def admin_user
      redirect_to root_path unless current_user and current_user.admin?
    end

    def instructor
      redirect_to root_path unless current_user and current_user.instructor?
    end
end
