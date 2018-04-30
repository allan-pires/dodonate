class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      flash[:success] = "Item added to donation!"
      redirect_to '/home'
    else
      render 'new'
    end
  end

  def edit
  end

  private 

  def item_params
    params.require(:item).permit(:name, :quantity)
  end

end
