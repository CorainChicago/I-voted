class HTMLVoterDataParser
  require 'open-uri'
  require 'nokogiri'
  require 'json'

  def parse
    @doc = Nokogiri::HTML(open("https://www.usvotefoundation.org/vote/state-elections/state-voting-laws-requirements.htm"))

    @table = @doc.search("table.election-dates")
    @rows = @table.search("tr")
    @data = []
    counter = 1
    55.times do 
      state = Hash.new
      state["name"] = @rows[counter].search("td").first.text.strip
      state["Early In-Person Voting"] = @row
s[counter].search("td:nth-child(2)").text.strip
      state["No Excuse Absentee Voting"] = @rows[counter].search("td:nth-child(3)").text.strip
      state["Absentee Voting with Excuse"] = @rows[counter].search("td:nth-child(4)").text.strip
      state["Same Day Voter Registration"] = @rows[counter].search("td:nth-child(5)").text.strip
      state["All-Mail Voting"] = @rows[counter].search("td:nth-child(6)").text.strip
      state["Voter ID on Election Day"] = @rows[counter].search("td:nth-child(7)").text.strip
      @data << state
      counter += 1
    end
  end

  def save_data
    File.open("public/state_data.json","w") do |f|
      f.write(@data.to_json)
    end
  end

end

p = HTMLVoterDataParser.new
p.parse
p.save_data
