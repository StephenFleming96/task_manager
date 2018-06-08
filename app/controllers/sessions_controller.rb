class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:email])

		if user.nil? || !user&.name && !user.authenticate(params[:password])
			redirect_to '/register'
		end

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			session[:expiry] = Time.current + 24.hours

			redirect_to '/dash'
		else
			#redirect_to '/login'
		end
	end

	def destroy
		session[:user_id] = nil 
		session[:expiry] = nil
		redirect_to '/login'
	end
end
