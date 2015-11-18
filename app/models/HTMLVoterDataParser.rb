
class HTMLVoterDataParser
  require 'open-uri'
  require 'Nokogiri'
  require 'json'

  def parse
    @doc = Nokogiri::HTML(open("https://www.usvotefoundation.org/vote/state-elections/state-voting-laws-requirements.htm"))

    @table = @doc.search("table.election-dates")
    @rows = @table.search("tr")
    @data = []
    counter = 1
    53.times do 
      state = Hash.new
      state["name"] = @rows[counter].search("td").first.text
      state["Early In-Person Voting"] = @rows[counter].search("td:nth-child(2)").text
      state["No Excuse Absentee Voting"] = @rows[counter].search("td:nth-child(3)").text
      state["Absentee Voting with Excuse"] = @rows[counter].search("td:nth-child(4)").text
      state["Same Day Voter Registration"] = @rows[counter].search("td:nth-child(5)").text
      state["All-Mail Voting"] = @rows[counter].search("td:nth-child(6)").text
      state["Voter ID on Election Day"] = @rows[counter].search("td:nth-child(7)").text
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

