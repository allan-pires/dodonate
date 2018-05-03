class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :check_login, only: [:edit, :update, :delete]

  private 
  
  def check_login
    unless logged_in?
      flash[:error] = "Please log in."
      redirect_to login_path
    end
  end

end
