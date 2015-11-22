
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def scraper(zip_code, zip_code_formatted)

    $browser = Watir::Browser.new
    $browser.goto "http://www.rockthevote.com/get-informed/elections/find-your-polling-place/?myaddress=" + zip_code_formatted.to_s + "#koqg"
    at_exit { $browser.close if $browser}
    candidate_html = Nokogiri::HTML($browser.html)

    candidates = {}

    # @zip = Zipcode.create(zip: zip_code)
    candidate_html.css('.candidate-list-item').each do |candidate_list|
      candidates[candidate_list.css('.office-title').inner_text] = []

      candidate_list.css('.candidate-name').each do |candidate|
          array = candidate.inner_text.split("|")
          Candidate.create(name: array[0].strip, office: candidate_list.css('.office-title').inner_text, party_affiliation: array[1].strip, zip: zip_code)
      end
    end
    candidates
  end


    def load_zip_codes


      CSV.foreach("db/zipcodes/us_postal_codes_three_two.csv") do |row|


        scraper(row[0], ([row[0],row[1],row[2],row[3],row[4]]).join('+').gsub(' ', "+"))
        $browser.close
      end
    end


  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    session[:user_id] != nil
  end

  helper_method :current_user
  helper_method :logged_in?
end
