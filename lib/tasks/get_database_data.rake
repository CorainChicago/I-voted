desc "generate a seeds file from data in the database"
  task "db:dump_seeds" do
    Candidates.all.each do |candidate|
      Candidate.create!({name: candidate.name, office: candidate.office, party_affiliation: candidate.party_affiliation, zip_id: candidate.zip_id})
    end
end