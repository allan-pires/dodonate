class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to '/home'
    else
      flash[:danger] = 'Invalid email or password :('
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to home_path
  end

end
