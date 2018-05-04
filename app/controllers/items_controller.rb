class ItemsController < ApplicationController
  before_action :item_exists?, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      flash[:success] = "Item added to donation!"
      redirect_to items_path
    else
      flash[:danger] = "Failed to create item!"
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated!"
      redirect_to items_path
    else
      flash[:danger] = "Failed to update item!"
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:success] = "Item deleted!"
    else
      flash[:danger] = "Failed to destroy item!"
    end
    
    redirect_to items_path
  end

  private 

  def item_params
    params.require(:item).permit(:name, :item_category_id, :description, :quantity)
  end

  def check_permission
    item = Item.find(params[:id])
    if item && item.user_id != current_user.id
      flash[:danger] = "Permission denied!"
      redirect_to items_path
    end
  end

  def item_exists?
    unless Item.exists?(params[:id])
      render 'static_pages/not_found'
    end
  end

end
