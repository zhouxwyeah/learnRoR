module SessionsHelper

	def log_in(user)
		session[:user_id] = user.id
	end

	def remeber(user)
		user.remeber
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:user_token] = user.remeber_token
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:user_token)
	end

	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])

		elsif cookies.signed[:user_id]
			user = User.find_by(id: cookies.signed[:user_id])

			if user && user.authenticated?(cookies[:user_token])
				log_in user
				@current_user = user
			end			
		end
	#@current_user = @current_user || User.find_by(id: session[:user_id])
	#@current_user ||= User.find_by(id: session[:user_id])
	end

	def logged_in?
	
		!current_user.nil?

	end

	def log_out
		
		if(current_user)

			forget current_user

		end
		
		session.delete(:user_id)
		@current_user = nil
	end

end
