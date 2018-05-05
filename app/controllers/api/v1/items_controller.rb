class Api::V1::ItemsController < Api::V1::ApiController
  before_action  :item_exists?, only: [ :show, :update, :destroy ]

  def index
    render json: Item.all
  end
  
  def show
    render json: @item
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: item
    else
      render json: { errors: 'Failed to create item' }
    end
  end

  def update    
    if @item.update_attributes(item_params)      
      render json: @item
    else
      render json: { errors: 'Failed to update item' }
    end
  end

  def destroy
    if @item.destroy
      render json: { message: 'Item deleted!' }
    else
      render json: { errors: 'Failed to delete item' }
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

  def item_params
    params.require(:item).permit(:name, :item_category_id, :description, :quantity)
  end
end