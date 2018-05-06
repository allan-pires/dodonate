class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    result = CRUDService.create(User, user_params)
    if result.success?
      flash[:success] = "Account created! Please log in"
      redirect_to login_path
    else
      flash[:danger] = "Failed to create new account"
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    if CRUDService.update(current_user, user_params).success?
      flash[:success] = "Profile updated!"
      redirect_to profile_path
    else
      flash[:danger] = "Failed to update profile"
      render 'edit'
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
