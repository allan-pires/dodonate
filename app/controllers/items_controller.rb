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
    logger.info("Creating new item with [params] = #{item_params.inspect} ")

    begin
      @item.save
      success_redirect
    rescue StandardError => e
      log_error_and_redirect(e.message)
    end
  end

  def edit
    @item = find_item(params[:id])
  end

  def update
    logger.info("Updating item with [params] = #{item_params.inspect} ")
    @item = find_item(params[:id])

    begin
      @item.update_attributes(item_params)
      success_redirect
    rescue StandardError => e
      log_error_and_redirect(e.message)
    end
  end

  def destroy
    logger.info("Deleting item with [id] = [#{params[:id]}]")
    @item = find_item(params[:id])
    
    begin
      @item.destroy      
      success_redirect
    rescue StandardError => e
      log_error_and_redirect(e.message)
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
      log_error_and_redirect(e.message)
    end
  end

  def success_redirect
    logger.info("Operation successful")
    flash[:success] = "All done!"
    redirect_to items_path
  end

  def log_error_and_redirect(error_message)
    logger.error(error_message)
    flash[:danger] = "Something went wrong, sorry!"
    redirect_to items_path
  end

end
