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
    result = ItemService.create_item(item_params, current_user)
    render_result(result)
  end

  def update
    result = ItemService.update_item(@item, item_params)
    render_result(result)
  end

  def destroy
    result = ItemService.delete_item(@item)
    render_result(result)    
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