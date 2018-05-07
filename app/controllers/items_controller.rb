class ItemsController < ApplicationController
  before_action :item_exists?, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:edit, :update, :destroy]

  def index
    @own_items = Item.owner(current_user).order("id asc")
    @other_items = Item.owner_not(current_user).order("id asc")
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
  end

  def create
    result = CRUDService.create(Item, item_params_with_user)
    @item = result.obj

    if result.success?    
      flash[:success] = "Item added to donation!"
      return redirect_to items_path
    end

    render 'new'
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    result = CRUDService.update(@item, item_params)
    if result.success?     
      flash[:success] = "Item updated!"
      return redirect_to items_path
    end

    render 'edit'
  end

  def destroy
    item = Item.find(params[:id])
    result = CRUDService.delete(item)
    if result.success?    
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

  def item_params_with_user
    params = item_params
    params[:user_id] = current_user.id
    params
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
