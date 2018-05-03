class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account created! Please log in"
      redirect_to login_path
    else
      flash[:error] = "Failed to create new account"
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to profile_path
    else
      flash[:error] = "Failed to update profile"
      render 'edit'
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
