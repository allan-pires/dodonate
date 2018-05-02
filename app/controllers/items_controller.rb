class ItemsController < ApplicationController

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
      flash[:success] = "Item added to donation!"
      redirect_to home_path
    else
      render 'new'
    end
  end

  def edit
    @item = find_item(params[:id])
  end

  def update
    @item = find_item(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "All done!"
      redirect_to items_path
    else
      render 'edit'
    end
  end

  def destroy
    check_ownership
    @item = find_item(params[:id])
    if @item.user_id = current_user.id
      @item.destroy
      flash[:success] = "Item deleted!"
      redirect_to items_path
    end
  end

  private 

  def item_params
    params.require(:item).permit(:name, :item_category_id, :description, :quantity)
  end

  def check_permission
    if !check_ownership(params[:id])
      logger.error("Permission denied!")
      error_redirect
    end
  end

  def check_ownership(item_id)
    item = find_item(item_id)
    item.user_id == current_user.id
  end

  def find_item(id)
    begin
      Item.find(id)
    rescue StandardError => e
      logger.error(e.message)
      error_redirect
    end
  end

  def error_redirect
      flash[:danger] = "Something went wrong, sorry!"
      redirect_to items_path
  end

end
