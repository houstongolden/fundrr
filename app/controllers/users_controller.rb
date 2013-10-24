class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.create(params[:user].permit(:name, :email, :password, :password_confirmation))
		redirect_to root_url
	end
	

end
