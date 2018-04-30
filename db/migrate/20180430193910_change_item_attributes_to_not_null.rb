class ChangeItemAttributesToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :items, :name, false
    change_column_null :items, :quantity, false
    change_column_null :items, :user_id, false
    change_column_null :items, :item_category_id, false
  end
end
