class CreateStateElectionData < ActiveRecord::Migration
  def change
    create_table :state_election_data do |t|

      t.timestamps null: false
    end
  end
end
