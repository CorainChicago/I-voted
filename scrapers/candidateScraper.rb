require 'nokogiri'
require 'watir'
require 'csv'
def scraper(zip_code)
  $browser = Watir::Browser.new

  $browser.goto "http://www.rockthevote.com/get-informed/elections/find-your-polling-place/?myaddress=" + zip_code.to_s + "#koqg"
  at_exit { $browser.close if $browser }
  candidate_html = Nokogiri::HTML($browser.html)



  candidates = {}

  candidate_html.css('.candidate-list-item').each do |candidate_list|
    candidates[candidate_list.css('.office-title').inner_text] = []

    candidate_list.css('.candidate-name').each do |candidate|
        array = candidate.inner_text.split("|")
        candidates[candidate_list.css('.office-title').inner_text] << {"name" => array[0].strip, "party" => array[1].strip}
    end
  end

  p candidates


end
# def close_window
#   browser.close if browser
# end

def load_zip_codes
  scraper(55364)
  # CSV.foreach("us_postal_codes.csv") do |row|
  #   puts row
  # end
end
load_zip_codes
# close_window
