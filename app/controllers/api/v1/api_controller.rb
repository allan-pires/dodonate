class Api::V1::ApiController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  after_action :clear_user_data
  current_user = nil

  def require_authentication
    verify_authentication || render_unauthenticated
  end

  private 
  
  def verify_authentication
    case request.content_type
    when Mime[:json]
      authenticate_with_http_basic do |email, password| 
        result = AuthenticationService.authenticate(email, password) 
        if result.success?
          @current_user = result.obj
        end
      end
    end
  end

  def render_result(result)
    if result.success?
      render json: result.obj
    else
      render json: { errors: result.obj.errors.full_messages }
    end
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