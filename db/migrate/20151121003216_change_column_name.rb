class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :candidates, :zip_id, :zip
  end
end
