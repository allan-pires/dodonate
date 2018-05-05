class Api::V1::ApiController < ActionController::API

  def require_login
    authenticate_user || render_unauthorized
  end

  private 
  
  def authenticate_user
    authenticate_with_http_basic do |email, password|
      user = User.find_by_email(email)
      user && user.authenticate(params[:session][:password])
    end
  end

  def render_internal_error
    render json: { errors: 'Internal error' }
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