class Api::V1::UsersController < Api::V1::ApiController
  before_action :require_login, only: [:create, :update, :destroy]
  before_action :user_exists?, only: [ :show, :update, :destroy ]
  before_action :check_permission, only: [:edit, :update, :destroy]

  def index
    render json: User.all
  end
  
  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: { errors: 'Failed to create user' }
    end
  end

  def update    
    if @user.update_attributes(user_params)      
      render json: @user
    else
      render json: { errors: 'Failed to update user' }
    end
  end

  def destroy
    if @user.destroy
      render json: { message: 'User deleted!' }
    else
      render json: { errors: 'Failed to delete user' }
    end    
  end

  private 

  def user_exists?
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_not_found
    end
  end

  def check_permission
    user = User.find(params[:id])
    if user && user.id != current_user.id
      render_unauthorized
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end