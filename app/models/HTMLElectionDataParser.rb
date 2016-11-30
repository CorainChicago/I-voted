class HTMLElectionDataParser
  require 'open-uri'
  require 'nokogiri'
  require 'json'
  require 'csv'

  def parse
    @doc = Nokogiri::HTML(open("https://www.usvotefoundation.org/vote/state-elections/state-election-dates-deadlines.htm"))
    @table = @doc.search("table.election-dates")
    @rows = @table.search("tr")
    @data = []
    if @doc.search("table.election-dates").length > 0
      counter = 1
      while @rows[counter] do
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
    else
      election_dates = @doc.search('.election-dates')
      counter = 0
      while election_dates[counter + 1] do
        state = Hash.new
        state["Election Title"] = election_dates[counter].search("h2")[0].text.split('-')[0]
        state["Election Date"] = election_dates[counter].search("h2")[0].text.split('-')[1]
        state["Voter Registration"] = election_dates[counter + 1].search('div')[0].text.split('Voter Registration ')[1]
        state["Absentee Ballot Request"] = election_dates[counter + 1].search('div')[1].text.split('Absentee Ballot Request')[1]
        state["Absentee Ballot Return"] = election_dates[counter + 1].search('div')[2].text.split('Absentee Ballot Return')[1]
        state["Early In-Person Voting"] = election_dates[counter + 1].search('div')[3].text.split('Early Voting ')[1]&.strip
        @data << state
        counter += 2
      end
    end
  end

  def save_data
    File.open("public/election_data.json","w") do |f|
      f.write(@data.to_json)
    end
  end

  def update_data
    parse
    save_data
    StateElectionInfo.all.delete_all
    election_records = JSON.parse(File.read('public/election_data.json'))
      election_records.each do |record|
        StateElectionInfo.create!(election_title: record["Election Title"], election_date: record["Election Date"],
          voter_registration: record["Voter Registration"],
          absentee_ballot_request: record["Absentee Ballot Request"],
          absentee_ballot_return: record["Absentee Ballot Return"],
          early_in_person_voting: record["Early In-Person Voting"]  )
      end
  end
end

