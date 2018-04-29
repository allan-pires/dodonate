class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "We missed you!"
      redirect_to user
    else
      render 'new'
    end
  end

end
