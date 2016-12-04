class HTMLVoterDataParser
  require 'open-uri'
  require 'nokogiri'
  require 'json'
  require 'csv'

  def parse
    @doc = Nokogiri::HTML(open("https://www.usvotefoundation.org/vote/state-elections/state-voting-laws-requirements.htm"))

    @table = @doc.search("table.election-dates")
    @rows = @table.search("tr")
    @data = []
    counter = 1
    55.times do 
      state = Hash.new
      state["name"] = @rows[counter].search("td").first.text.strip
      state["Early In-Person Voting"] = (@rows[counter].search("td:nth-child(6)").search('.glyphicon-ok').length > 0 ? "✓" : ' ')
      state["No Excuse Absentee Voting"] = (@rows[counter].search("td:nth-child(5)").search('.glyphicon-ok').length > 0 ? "✓" : ' ')
      state["Absentee Voting with Excuse"] = (@rows[counter].search("td:nth-child(4)").search('.glyphicon-ok').length > 0 ? "✓" : ' ')
      state["Same Day Voter Registration"] = (@rows[counter].search("td:nth-child(3)").search('.glyphicon-ok').length > 0 ? "✓" : ' ')
      state["All-Mail Voting"] = (@rows[counter].search("td:nth-child(8)").search('.glyphicon-ok').length > 0 ? "✓" : ' ')
      state["Provisional Voting"] = (@rows[counter].search("td:nth-child(9)").search('.glyphicon-ok').length > 0 ? "✓" : ' ')
      
      @data << state
      counter += 1
    end
  end

  def save_data
    File.open("public/state_data.json","w") do |f|
      f.write(@data.to_json)
    end
  end

  def update_data
    parse
    save_data
    StateVotingInformation.all.delete_all
    state_data = JSON.parse(File.read('public/state_data.json'))
    state_data.each do |record|
      if record["Early In-Person Voting"].include?("✓") || record["Early In-Person Voting"].include?("✓ ")
        record["Early In-Person Voting"] = true
      else
        record["Early In-Person Voting"] = false
      end

      if record["No Excuse Absentee Voting"].include?("✓") || record["No Excuse Absentee Voting"].include?("✓ ")
        record["No Excuse Absentee Voting"] = true
      else
        record["No Excuse Absentee Voting"] = false
      end

      if record["Absentee Voting with Excuse"].include?("✓") || record["Absentee Voting with Excuse"].include?("✓ ")
        record["Absentee Voting with Excuse"] = true
      else
        record["Absentee Voting with Excuse"] = false
      end

      if record["Same Day Voter Registration"].include?("✓") || record["Same Day Voter Registration"].include?("✓ ")
        record["Same Day Voter Registration"] = true
      else
        record["Same Day Voter Registration"] = false
      end

      if record["Provisional Voting"].include?("✓") || record["Provisional Voting"].include?("✓ ")
        record["Provisional Voting"] = true
      else
        record["Provisional Voting"] = false
      end

      StateVotingInformation.create!(
          name: record["name"],
          early_in_person_voting: record["Early In-Person Voting"],no_excuse_absentee_voting: record["No Excuse Absentee Voting"],  absentee_voting_with_excuse: ["Absentee Voting with Excuse"],same_day_voter_registration: record["Same Day Voter Registration"], all_mail_voting: record["All-Mail Voting"], provisional_voting: record["Provisional Voting"])
    end
  end

end

# p = HTMLVoterDataParser.new
# p.parse
# p.save_data
