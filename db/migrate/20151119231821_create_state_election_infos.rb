class CreateStateElectionInfos < ActiveRecord::Migration
  def change
    create_table :state_election_infos do |t|
      t.string :election_title
      t.string :election_date
      t.string :voter_registration
      t.string :absentee_ballot_request
      t.string :absentee_ballot_return
      t.string :early_in_person_voting

      t.timestamps null: false
    end
  end
end
