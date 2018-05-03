class UsersController < ApplicationController
  before_action :check_login, only: [:edit, :update, :destroy]

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

    if @user.save
      success_feedback
      redirect_to login_path
    else
      failure_feedback
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      success_feedback
      redirect_to profile_path
    else
      failure_feedback
      render 'edit'
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
