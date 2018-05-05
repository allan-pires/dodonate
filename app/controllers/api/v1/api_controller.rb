class Api::V1::ApiController < ActionController::API

  def require_login
    authenticate_user || render_unauthorized
  end

  def authenticate_user
    puts "------------------------>>>>>>>>> AUTH #{email}@#{password}"
    authenticate_with_http_basic do |email, password|
      user = User.find_by_email(email)
      user && user.authenticate(params[:session][:password])
    end
  end

  def render_unauthorized
    render json: { status: 403, errors: 'Not authorized' }
  end

  def render_unauthenticated
    render json: { status: 401, errors: 'Not authenticated' }
  end

  def render_not_found
    render json: { status: 404, errors: 'Resource not found' }
  end

end