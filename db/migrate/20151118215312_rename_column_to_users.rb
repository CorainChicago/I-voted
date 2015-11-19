class RenameColumnToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :address, :street_address
  end
end
