require 'json'

class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@errors = params[:errors]

		if @errors != nil
			@errors = JSON.parse(params[:errors])
		end

		@user = User.new
	end

	def create
		@user = User.new(user_params)

		@user.password = user_params[:password]
		@user.password_confirm = user_params[:password_confirm]

		if @user.save
			redirect_to '/login'
		else 
			redirect_to(controller: "users", action: "new", errors: @user.errors.to_json)
		end
	end

	def show
		if (!session[:user_id] || !session[:expiry] || session[:expiry] < Time.current)
			redirect_to '/login'
		end
		
		@user = User.find(session[:user_id])
	end

	def edit
		@user = User.find(session[:user_id])
		@errors = params[:errors]

		if @errors != nil
			@errors = JSON.parse(params[:errors])
		end

		if (!@user)
			redirect_to '/login'
		end
	end

	def update 
		if (!session[:user_id] || !session[:expiry] || session[:expiry] < Time.current)
			redirect_to '/login'
		end

		user = User.find(session[:user_id])

		if (!user)
			redirect_to '/register'
		end

		user.update(name: params[:user][:name])
		user.update(email: params[:user][:email])
		user.update(password: params[:user][:password])
		user.update(password_confirm: params[:user][:password_confirm])

		if user.save
			redirect_to '/user'
		else
			redirect_to(controller: "users", action: "edit", errors: user.errors.to_json)
		end
	end

	def destroy
		if (!session[:user_id] || !session[:expiry] || session[:expiry] < Time.current)
			redirect_to '/login'
		end

		user = User.find(session[:user_id])

		if (!user)
			redirect_to '/register'
		end

		user.destroy

		redirect_to '/'
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirm)
		end
end

