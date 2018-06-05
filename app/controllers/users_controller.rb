class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		@user.password = user_params[:password]
		@user.password_confirm = user_params[:password_confirm]

		if @user.save
			redirect_to '/login'
		else 
			redirect_to '/register'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirm)
		end
end

