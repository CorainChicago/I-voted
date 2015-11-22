class HTMLElectionDataParser
  require 'open-uri'
  require 'nokogiri'
  require 'json'

  def parse
    @doc = Nokogiri::HTML(open("https://www.usvotefoundation.org/vote/state-elections/state-election-dates-deadlines.htm"))

    @table = @doc.search("table.election-dates")
    @rows = @table.search("tr")
    @data = []
    counter = 1
    169.times do
      state = Hash.new
      state["Election Title"] = @rows[counter].search("td.election-title").text
      state["Election Date"] = @rows[counter].search("td:nth-child(2)").text
      state["Voter Registration"] = @rows[counter].search("td:nth-child(3)").text
      state["Absentee Ballot Request"] = @rows[counter].search("td:nth-child(4)").text
      state["Absentee Ballot Return"] = @rows[counter].search("td:nth-child(5)").text
      state["Early In-Person Voting"] = @rows[counter].search("td:nth-child(6)").text
      @data << state
      counter += 1
    end
  end

  def save_data
    File.open("public/election_data.json","w") do |f|
      f.write(@data.to_json)
    end
  end

end

parsed = HTMLElectionDataParser.new
parsed.parse
parsed.save_data
