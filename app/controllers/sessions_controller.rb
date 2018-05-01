class SessionsController < ApplicationController
  
  def new
  end

  def create
    logger.info("Creating new session")
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    logger.info("Logging user [id = #{user.id}, name = #{user.name}]")
      log_in user
      redirect_to home_path
    else
      logger.info("Authentication failed")
      flash[:danger] = 'Invalid email or password :('
      render 'new'
    end
  end

  def destroy
    logger.info("Logging out user [id = #{current_user.id}, name = #{current_user.name}] ")
    log_out
    redirect_to home_path
  end

end
