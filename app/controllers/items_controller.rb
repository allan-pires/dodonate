class ItemsController < ApplicationController
  
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
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "All done!"
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  private 

  def item_params
    params.require(:item).permit(:name, :description, :quantity)
  end

end
