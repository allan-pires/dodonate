class ItemsController < ApplicationController
  include ItemsHelper
  before_action :check_login
  before_action :check_permission, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @item = find_item(params[:id])
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id

    if @item.save
      success_redirect
    else
      error_redirect
    end
  end

  def edit
    @item = find_item(params[:id])
  end

  def update
    @item = find_item(params[:id])

    if @item.update_attributes(item_params)
      success_redirect
    else
      error_redirect
    end
  end

  def destroy
    @item = find_item(params[:id])
    
    if @item.destroy      
      success_redirect
    else
      error_redirect
    end
  end

  private 

  def item_params
    params.require(:item).permit(:name, :item_category_id, :description, :quantity)
  end

  def find_item(id)
    begin
      Item.find(id)
    rescue StandardError => e
      logger.error(e.message)
      error_redirect
    end
  end

  def success_redirect
    success_feedback
    redirect_to items_path
  end

  def error_redirect
    failure_feedback
    redirect_to items_path
  end

end
