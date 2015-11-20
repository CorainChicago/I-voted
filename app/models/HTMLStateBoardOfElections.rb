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

  def data
    @data
  end

  def save_data
    File.open("public/us_secretary_of_states","w") do |f|
      f.write(@data.to_json)
    end
  end

end

sos = HTMLStateBoardOfElections.new
sos.parse
sos.save_data
all_states = sos.data

all_states.each do |state| 
  p state
  state = StateVotingInformation.find_by(name: state.state_name)
  state.sos_url = sos.url
  p state.sos_url
end
