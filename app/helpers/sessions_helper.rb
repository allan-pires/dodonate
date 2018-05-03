module SessionsHelper
  def current_user
    if !session[:user_id].nil?
      User.find(session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
end