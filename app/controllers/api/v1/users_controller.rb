class Api::V1::UsersController < Api::V1::ApiController
  before_action :require_authentication, only: [:index, :show, :update, :destroy]  
  before_action :user_exists?, only: [ :show, :update, :destroy ]
  before_action :check_permission, only: [:show, :edit, :update, :destroy]
  wrap_parameters :user, include: [:name, :email, :password, :password_confirmation]

  def index
    render json: User.all
  end
  
  def show
    render json: @user
  end

  def create
    result = CRUDService.create(User, user_params)
    render_result(result)
  end

  def update
    result = CRUDService.update(@user, user_params)
    render_result(result)
  end

  def destroy
    result = CRUDService.delete(@user)
    render_result(result)
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