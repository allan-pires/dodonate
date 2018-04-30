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
    check_user
    @item = find_item
  end

  def update
    @item = find_item
    if @item.update_attributes(item_params)
      flash[:success] = "All done!"
      redirect_to items_path
    else
      render 'edit'
    end
  end

  def destroy
    check_user
    @item = find_item
    if @item.user_id = current_user.id
      @item.destroy
      flash[:success] = "Item deleted!"
      redirect_to items_path
    end
  end

  private 

  def find_item
    begin
      Item.find(params[:id])
    rescue
      flash[:danger] = "Something went wrong, sorry!"
      render_to items_path
    end
  end

  def check_user
    item = find_item
    if item.user_id != current_user.id
      flash[:danger] = "Hey, don't try that!"
      redirect_to items_path
    end
  end

  def item_params
    params.require(:item).permit(:name, :item_category_id, :description, :quantity)
  end

end
