class ItemService

  private

  def self.create_item(item_attributes, user)
    item = Item.new(item_attributes)
    item.user_id = user.id
    if item.save
      ServiceResult.new(item, true)
    else
      ServiceResult.new(item, false)
    end
  end

  def self.update_item(item, new_attributes)
    if item.update_attributes(new_attributes)
      ServiceResult.new(item, true)
    else
      ServiceResult.new(item, false)
    end
  end

  def self.delete_item(item)
    if item.destroy
      ServiceResult.new({message: "Item deleted!"}, true)
    else
      ServiceResult.new(item, false)
    end
  end

end