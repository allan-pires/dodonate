class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    logger.info("Creating new user with [params] = #{user_params.inspect} ")

    begin 
      @user.save
      logger.info("User succesfully created")
	    flash[:success] = "Account created! Please log in"
      redirect_to login_path
    rescue StandardError => e
      logger.error(e.message)
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    logger.info("Updating user with [params] = #{user_params.inspect}")

    begin
      @user.update_attributes(user_params)
      logger.info("User succesfully updated")
      flash[:success] = "All done!"
      redirect_to profile_path
    rescue StandardError => e
      logger.error(e.message)
      render 'edit'
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
