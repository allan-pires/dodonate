class Api::V1::ApiController < ActionController::API

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  
  after_action :clear_user_data
  current_user = nil

  def require_authentication
    verify_authentication || render_unauthenticated
  end

  private 

  def render_result(result)
    if result.success?
      render json: result.obj
    else
      render json: { errors: result.obj.errors.full_messages }
    end
  end
  
  def verify_authentication
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