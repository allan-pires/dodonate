class ApplicationController < ActionController::Base
  include SessionsHelper
  
  before_action :check_login, only: [:edit, :update, :destroy]
  protect_from_forgery with: :exception

  private 
  
  def check_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end
end
