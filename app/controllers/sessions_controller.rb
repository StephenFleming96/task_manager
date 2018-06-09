class SessionsController < ApplicationController
	def new
		@errors = params["errors"]

		if @errors
			@errors = true
		end
	end

	def create
		user = User.find_by(email: params[:email])
		errors = false

		if !user || !user&.name && !user.authenticate(params[:password])
			errors = true
		end

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			session[:expiry] = Time.current + 24.hours

			redirect_to '/dash'
		else
			errors = true
			redirect_to(controller: "sessions", action: "new", errors: errors)
		end
	end

	def destroy
		session[:user_id] = nil 
		session[:expiry] = nil
		redirect_to '/login'
	end
end
