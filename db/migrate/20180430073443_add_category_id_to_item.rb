class AddCategoryIdToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :category_id, :integer
  end
end
