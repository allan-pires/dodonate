class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  private 
  
  def check_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def success_feedback
    logger.info "Operation successful"
    flash[:success] = "All done!"
  end

  def failure_feedback
    logger.error "Operation failed"
    flash[:danger] = "Something went wrong, sorry!"
  end

end
