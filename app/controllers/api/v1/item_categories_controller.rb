class Api::V1::ItemCategoriesController < Api::V1::ApiController
  before_action  :item_exists?, only: [ :show, :update, :destroy ]

  def index
    render json: ItemCategory.all
  end
  
  def show
    render json: @item_category
  end

  def create
    item_category = ItemCategory.new(item_category_params)
    if item_category.save
      render json: item_category
    else
      render json: { errors: 'Failed to create item category' }
    end
  end

  def update    
    if @item_category.update_attributes(item_category_params)      
      render json: @item_category
    else
      render json: { errors: 'Failed to update item category' }
    end
  end

  def destroy
    if @item_category.destroy
      render json: { message: 'Item category deleted!' }
    else
      render json: { errors: 'Failed to delete item category' }
    end    
  end

  private 

  def item_exists?
    begin
      @item_category = ItemCategory.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_not_found
    end
  end

  def item_category_params
    params.require(:item_category).permit(:description)
  end

end