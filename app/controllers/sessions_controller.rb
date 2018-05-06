class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = AuthenticationService.authenticate(params[:email], params[:password])    
    if user.success?
      log_in user
      redirect_to home_path
    else
      flash[:danger] = 'Invalid email or password :('
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to home_path
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end

  def authentication_successful(user)
    user && user.authenticate(params[:session][:password])
  end

end
