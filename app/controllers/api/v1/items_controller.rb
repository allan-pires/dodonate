class Api::V1::ItemsController < Api::V1::ApiController
  before_action :require_authentication, only: [:create, :update, :destroy]
  before_action :item_exists?, only: [ :show, :update, :destroy ]
  before_action :check_permission, only: [:edit, :update, :destroy]
  wrap_parameters :item, include: [:name, :user_id, :item_category_id, :description, :quantity]

  def index
    render json: Item.all
  end
  
  def show
    render json: @item
  end

  def show_by_user
    items = Item.owner(params[:user_id]).order("id asc")
    render json: items
  end

  def show_by_category
    items = Item.where(item_category_id: params[:item_category_id]).order("id asc")
    render json: items
  end

  def create
    item = Item.new(item_params)
    item.user_id = @current_user.id
    if item.save
      render json: item
    else
      render json: { errors: item.errors.full_messages }
    end
  end

  def update    
    if @item.update_attributes(item_params)      
      render json: @item
    else
      render json: { errors: @item.errors.full_messages }
    end
  end

  def destroy
    if @item.destroy
      render json: { message: 'Item deleted!' }
    else
      render json: { errors: @item.errors.full_messages }
    end    
  end

  private 

  def item_exists?
    begin
      @item = Item.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_not_found
    end
  end

  def check_permission
    item = Item.find(params[:id])
    if item && item.user_id != current_user.id
      render_unauthorized
    end
  end

  def item_params
    params.require(:item).permit(:name, :item_category_id, :description, :quantity)
  end
end