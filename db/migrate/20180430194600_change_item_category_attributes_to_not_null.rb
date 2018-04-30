class ChangeItemCategoryAttributesToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :item_categories, :description, false
  end
end
