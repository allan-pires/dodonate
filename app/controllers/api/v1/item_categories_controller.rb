class Api::V1::ItemCategoriesController < Api::V1::ApiController
  before_action :item_category_exists?, only: [ :show, :update, :destroy ]

  def index
    render json: ItemCategory.all
  end
  
  def show
    render json: @item_category
  end

  def create
    result = ItemCategoryService.create_category(item_category_params)
    render_result(result)
  end

  def update    
    result = ItemCategoryService.update_category(@item_category, item_category_params)
    render_result(result)
  end

  def destroy
    result = ItemCategoryService.delete_category(@item_category)
    render_result(result)  
  end

  private 

  def item_category_exists?
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