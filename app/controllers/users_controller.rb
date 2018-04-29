class UsersController < ApplicationController
  def index
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    if @user.save
	  flash[:success] = "Hey! it's nice to have you here"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
