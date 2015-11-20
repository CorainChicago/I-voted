class AddInitialToZipcodes < ActiveRecord::Migration
  def change
    add_column :zipcodes, :abbreviation, :string
  end
end
