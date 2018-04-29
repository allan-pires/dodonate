class UsersController < ApplicationController

  before_action :check_login, only: [:edit, :update]
  before_action :check_user,   only: [:edit, :update]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "All done!"
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def check_user
    @user = User.find(params[:id])
    redirect_to(current_user) unless @user == current_user
  end

  def check_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
