class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email])

		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			session[:expiry] = Time.current + 24.hours

			redirect_to '/dash'
		else
			flash[:danger] = 'Your email or password is incorrect'
			#render 'new'
		end
	end

	def destroy
		session[:user_id] = nil 
		session[:expiry] = nil
		redirect_to '/'
	end

end
