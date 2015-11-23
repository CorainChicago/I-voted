class CreateStateWebsites < ActiveRecord::Migration
  def change
    create_table :state_websites do |t|
      t.string :name
      t.string :initials
      t.string :url

      t.timestamps null: false
    end
  end
end
