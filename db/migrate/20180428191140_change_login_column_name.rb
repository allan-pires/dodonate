class ChangeLoginColumnName < ActiveRecord::Migration[5.2]
  def self.up
  	rename_column :users, :login, :email
  end
end
