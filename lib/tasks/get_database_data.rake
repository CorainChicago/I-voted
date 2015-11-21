require_relative "../../config/environment.rb"

desc "generate a seeds file from data in the database"
  task "db:dump_seeds" do
    Candidate.all.each do |candidate|
      zip = candidate.zip.to_s.split("")
      if zip.length != 5
        needed_zeros = (5 - zip.length)
        needed_zeros.times do
         zip = zip.unshift("0")
        end
         zip = zip.join("")
      end
      puts "Candidate.create!(name: \"#{candidate.name}\", office: \"#{candidate.office}\", party_affiliation: \"#{candidate.party_affiliation}\", zip: #{zip})"
  end
end



# from command line run the code below to execute
# rake db:dump_seeds > db/<CREATE-NEW-FILE-NAME>.rb
