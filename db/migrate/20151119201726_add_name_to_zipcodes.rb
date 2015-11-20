class AddNameToZipcodes < ActiveRecord::Migration
  def change
    add_column :zipcodes, :state_name, :string
  end
end
