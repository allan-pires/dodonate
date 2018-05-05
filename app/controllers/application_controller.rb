class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :check_login, only: [:show, :edit, :update, :delete]

  private 
  
  def check_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

end
