class ChangePasswordColumnName < ActiveRecord::Migration[5.2]
  def self.up
  	rename_column :users, :encrypted_password, :password_digest
  end
end

