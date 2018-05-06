class ItemCategoryService

  private

  def self.create_category(item_category_attributes)
    item_category = ItemCategory.new(item_category_attributes)
    if item_category.save
      ServiceResult.new(item_category, true)
    else
      ServiceResult.new(item_category, false)
    end
  end

  def self.update_category(item_category, new_attributes)
    if item_category.update_attributes(new_attributes)
      ServiceResult.new(item_category, true)
    else
      ServiceResult.new(item_category, false)
    end
  end

  def self.delete_category(item_category)
    if item_category.destroy
      ServiceResult.new({message: "Item category deleted!"}, true)
    else
      ServiceResult.new(item_category, false)
    end
  end

end