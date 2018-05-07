class Api::V1::ApiController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  after_action :clear_user_data
  @current_user = nil

  def require_authentication
    verify_authentication || render_unauthenticated
  end

  private 
  
  def verify_authentication
    auth_result = nil
    
    if request.content_type == Mime[:json]
      authenticate_with_http_basic do |email, password| 
        auth_result = AuthenticationService.authenticate(email, password) 
      end
    end

    if auth_result && auth_result.success?
      @current_user = auth_result.obj
    end
  end

  def render_result(result)
    return render json: result.obj if result.success?
    render json: { errors: result.obj.errors.full_messages }
  end

  def current_user
    @current_user
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