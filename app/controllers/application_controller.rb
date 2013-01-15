class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_or_guest_user


  #if user is logged in, return current_user, else guest_user
  def current_or_guest_user
  	if current_user
  		if session[:guest_user_id]
  			loggin_in
  			guest_user.destroy
  			session[:guest_user_id] = nil
  		end
  		current_user
  	else
  		guest_user
  	end
  end

  #find or create guest_user object for current session
  def guest_user
  	User.find(session[:guest_user_id] ||= create_guest_user.id)
  end

  private

  	#called (once) when user logs in to hand off from guest to current_user
  	#sets guest attempts to current users attempts
  	def loggin_in
  		guest_attempts = guest_user.attempts.all
  		guest_attempts.each do |attempt|
  			attempt.user_id = current_user.id
  			attempt.save
  		end
  	end


  	#create guest user
  	def create_guest_user
  		u = User.create(fname: "guest",
  										email: "guest_#{Time.now.to_i}#{rand(99)}@example.com")
  		u.save(validate: false)
  		u
  	end


    def admin_user
      redirect_to root_path unless current_user and current_user.admin?
    end

    def instructor
      redirect_to root_path unless current_user and current_user.instructor?
    end
end
