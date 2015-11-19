# require_relative 'us_postal_codes.csv'
#
require 'csv'
def scraper(zip_code)
  $browser = Watir::Browser.new

  $browser.goto "http://www.rockthevote.com/get-informed/elections/find-your-polling-place/?myaddress=" + zip_code.to_s + "#koqg"
  at_exit { $browser.close if $browser }
  candidate_html = Nokogiri::HTML($browser.html)



  candidates = {}

  @zip = Zipcode.create(zip: zip_code)
  candidate_html.css('.candidate-list-item').each do |candidate_list|
    candidates[candidate_list.css('.office-title').inner_text] = []

    candidate_list.css('.candidate-name').each do |candidate|
        array = candidate.inner_text.split("|")
        @zip.candidates.create(name:array[0].strip , office:candidate_list.css('.office-title').inner_text , party_affiliation: array[1].strip)

        # candidates[candidate_list.css('.office-title').inner_text] << {"name" => array[0].strip, "party" => array[1].strip}
    end
  end
  candidates
end


def load_zip_codes
  CSV.foreach("us_postal_codes.csv") do |row|
     scraper(73069)
  end
end
load_zip_codes

