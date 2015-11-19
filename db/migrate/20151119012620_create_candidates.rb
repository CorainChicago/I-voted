class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :office
      t.string :party_affiliation

      t.timestamps null: false
    end
  end
end
