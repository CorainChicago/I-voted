class ChangeZipTypeToInteger < ActiveRecord::Migration
  def change
    change_column :candidates, :zip, :string
    change_column :zipcodes, :zip, :string
  end
end
