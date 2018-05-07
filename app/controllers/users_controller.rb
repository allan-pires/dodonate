class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    result = CRUDService.create(User, user_params)
    @user = result.obj

    if result.success?
      flash[:success] = "Account created! Please log in"
      return redirect_to login_path
    end

    render 'new'
  end

  def edit
    @user = current_user
  end

  def update
    result = CRUDService.update(current_user, user_params)
    @user = result.obj
    
    if result.success?
      flash[:success] = "Profile updated!"
      return redirect_to profile_path
    end
    
    render 'edit'
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
