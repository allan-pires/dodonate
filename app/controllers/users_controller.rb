class UsersController < ApplicationController

  before_action :check_login, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    if @user.save
	    flash[:success] = "Account created! Please log in"
      redirect_to '/login'
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "All done!"
      redirect_to '/profile'
    else
      render 'edit'
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_user
    @user = User.find(params[:id])
    redirect_to(current_user) unless @user == current_user
  end

  def check_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to '/login'
    end
  end

end
