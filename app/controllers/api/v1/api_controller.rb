class Api::V1::ApiController < ActionController::API
  after_action :clear_user_data

  include ActionController::HttpAuthentication::Basic::ControllerMethods

  current_user = nil

  def require_login
    authenticate_user || render_unauthenticated
  end

  private 
  
  def authenticate_user
    case request.content_type
    when Mime[:json]
      if user = authenticate_with_http_basic { |email, password| authenticate(email, password) }
        @current_user = user
      end
    end
  end

  def authenticate(email, password)
    user = User.find_by_email(email)
    user && user.authenticate(password)
  end

  def clear_user_data
    @current_user = nil
  end

  def render_unauthorized
    render json: { errors: 'Not authorized' }
  end

  def render_unauthenticated
    render json: { errors: 'Not authenticated' }
  end

  def render_not_found
    render json: { errors: 'Resource not found' }
  end

end