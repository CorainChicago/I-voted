
class ApplicationController < ActionController::Base
  helper_method :send_reminders_email, :set_sessions, :current_user, :logged_in?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def scraper(zip_code, zip_code_formatted)

    $browser = Watir::Browser.new
    $browser.goto "http://www.rockthevote.com/get-informed/elections/find-your-polling-place/?myaddress=" + zip_code_formatted.to_s + "#koqg"
    at_exit { $browser.close if $browser}
    candidate_html = Nokogiri::HTML($browser.html)

    candidates = {}
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
    CSV.foreach("db/zipcodes/us_postal_codes_three_one.csv") do |row|
      scraper(row[0], ([row[0],row[1],row[2],row[3],row[4]]).join('+').gsub(' ', "+"))
      $browser.close
    end


  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    session[:user_id] != nil
  end

  def set_sessions
    session[:zip] = current_user.zip
    session[:user_id] = current_user.id
  end


  def send_reminders_email
    date = Date.parse("%#{DateTime.now.day} %#{DateTime.now.mon}")
    if date.mon == 9 && date.day == 1
      User.all.each do |user|
        if user.subscribe == true && !user.reminder_emails.last.nil? && user.reminder_emails.last.subject != "elections coming up"
          IvotedMailer.reminder(user).deliver
          ReminderEmail.create(user_id: user.id, subject: "elections coming up")
        end
      end
    end
  end
