class Api::V1::ItemCategoriesController < Api::V1::ApiController
  before_action :require_login, :only => [ :create, :edit, :delete ]
  
  def show
    begin
      @item_category = ItemCategory.find(params[:id])
      render json: @item_category
    rescue ActiveRecord::RecordNotFound
      render_not_found
    end
  end

  private 

  def item_category_params
    params.require(:item_category).permit(:description)
  end

end