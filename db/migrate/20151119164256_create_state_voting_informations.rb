class CreateStateVotingInformations < ActiveRecord::Migration
  def change
    create_table :state_voting_informations do |t|
      t.string :name
      t.boolean :early_in_person_voting
      t.boolean :no_excuse_absentee_voting
      t.boolean :absentee_voting_with_excuse
      t.boolean :same_day_voter_registration
      t.string :all_mail_voting
      t.string :voter_id_on_election_day

      t.timestamps null: false
    end
  end
end
