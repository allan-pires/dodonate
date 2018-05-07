class SessionsController < ApplicationController
  
  def new
  end

  def create
    result = AuthenticationService.authenticate(params[:session][:email], params[:session][:password])   

    if result.success?
      log_in result.obj
      return redirect_to home_path
    end
    
    flash[:danger] = 'Invalid email or password :('
    render 'new'
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
