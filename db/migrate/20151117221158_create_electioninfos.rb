class CreateElectioninfos < ActiveRecord::Migration
  def change
    create_table :electioninfos do |t|
      t.string :title, null: false
      t.string :subtitle
      t.string :url, null: false

      t.timestamps null: false
    end
  end
end
