class Rename < ActiveRecord::Migration
  def change
  	rename_column :state_voting_informations, :voter_id_on_election_day, :provisional_voting
  end
end
