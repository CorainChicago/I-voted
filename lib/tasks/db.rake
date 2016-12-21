namespace :db do
  desc "Update state elections by scraping the data and writing it to database"
  task update_state_election_info: :environment do
  	load 'app/models/HTMLElectionDataParser.rb'
  	parsed = HTMLElectionDataParser.new
  	parsed.update_data
  end

  desc "Update state elections by scraping the data and writing it to database"
  task update_state_voter_info: :environment do
  	load 'app/models/HTMLVoterDataParser.rb'
  	parsed = HTMLVoterDataParser.new
	parsed.update_data
  end

end
