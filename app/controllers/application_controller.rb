class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  OPERATION_SUCCESS = "Operation successful"
  OPERATION_FAILED = "Operation failed"

  private 
  
  def check_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def success_feedback
    logger.info(OPERATION_SUCCESS)
    flash[:success] = "All done!"
  end

  def failure_feedback
    logger.error(OPERATION_FAILED)
    flash[:danger] = "Something went wrong, sorry!"
  end
  
end
