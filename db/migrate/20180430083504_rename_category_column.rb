class RenameCategoryColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :category_id, :item_category_id
  end
end
