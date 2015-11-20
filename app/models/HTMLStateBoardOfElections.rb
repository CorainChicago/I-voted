class HTMLStateBoardOfElections
  require 'open-uri'
  require 'nokogiri'
  require 'json'

  def parse
    @doc = Nokogiri::HTML(open("http://www.rockthevote.com/get-informed/elections/contact-sos/"))

    @table = @doc.search("table")
    @rows = @table.search("tr")
    @data = []
    counter = 1
    51.times do 
      state = Hash.new
      state["state_name"] = @rows[counter].search("td").first.text.strip
      state["url"] = @rows[counter].search("td:nth-child(3)").text
      @data << state
      counter += 1
    end
  end

  def save_data
    File.open("public/us_secretary_of_states","w") do |f|
      f.write(@data.to_json)
    end
  end

end

p = HTMLStateBoardOfElections.new
p.parse
p.save_data

50.times do 
  state = State_voting_information.find_by(name: p.state_name)
  state.sos_url = p.url
end
