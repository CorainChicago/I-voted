class AddSosUrlToStateVotingInformations < ActiveRecord::Migration
  def change
    add_column :state_voting_informations, :sos_url, :string
  end
end
