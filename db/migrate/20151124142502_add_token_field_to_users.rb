class AddTokenFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
  end
end
