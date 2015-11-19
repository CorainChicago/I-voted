require_relative "../../config/environment.rb"
desc "generate a seeds file from data in the database"
  task "db:dump_seeds" do
    Candidate.all.each do |candidate|
      "Candidate.create!({name: #{candidate.name}, office: #{candidate.office}, party_affiliation: #{candidate.party_affiliation}, zip_id: #{candidate.zip_id}})"
      # puts candidate
  end
end

# from command line run the code below to execute
# rake db:dump_seeds > db/candidates_seeds.rb