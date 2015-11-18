module Scraper

  def self.get_table
    doc = Nokogiri::HTML(open("https://www.usvotefoundation.org/vote/state-elections/state-voting-laws-requirements.htm"))
    table = doc.search("table.election-dates")
    rows = table.search("tr")
    rows[1].search("td").first.text #This gets me Alabama

    
  end
  
end