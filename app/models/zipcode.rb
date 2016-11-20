class Zipcode < ActiveRecord::Base
  require 'net/http'
  require 'json'
  require 'csv'

  def self.make_zipcode_object(zip_string)
    zip_file = 'db/zipcodes/us_postal_codes_all_zips.csv'
    zip_file_text = File.read(zip_file)
    zip_file_csv = CSV.parse(zip_file_text, headers: false)
    state_info_row = zip_file_csv.find {|row| row[0] == zip_string}
    return nil if state_info_row.blank?
    new(zip: state_info_row[0].try(:to_s), state_name: state_info_row[2], abbreviation: state_info_row[3])
  end

  def self.get_polling_place(address)
    uri = URI.parse("https://www.googleapis.com/civicinfo/v2/voterinfo?key=#{ENV['API_KEY']}&address=#{address.gsub(' ', '%20')}&electionId=2000")
    response = JSON.parse(Net::HTTP.get(uri))
    if response['pollingLocations']
      return response['pollingLocations'][0]
    else
      {'address' => 'Sorry, we can\'t find a polling place for your location at this time. Please try a different address or check back closer to election day.'}
    end
  end

  def self.get_zipcode(address)
    uri_address = address.gsub(" ", '%20')
    uri = URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{uri_address}")
    response = JSON.parse(Net::HTTP.get(uri))
    if response['status'] != 'ZERO_RESULTS'
      if response['results'][0]['address_components'][6]['short_name'].to_s.length == 5
        return response['results'][0]['address_components'][6]['short_name']
      elsif response['results'][0]['address_components'][7]['short_name'].to_s.length == 5
        return response['results'][0]['address_components'][7]['short_name']
      end
    end
    nil
  end
  def self.get_district(address)
    uri = URI.parse("https://www.googleapis.com/civicinfo/v2/voterinfo?key=#{ENV['API_KEY']}&address=#{address.gsub(' ', '%20')}&electionId=2000")
    response = JSON.parse(Net::HTTP.get(uri))
    if response['contests']
      response['contests'].each do |response|
        if response['office']
          if response['office'].include?('US House of Representatives')
          return response['district']['name']
          end
        end
      end
    end
    return "Sorry, we couldn't find a district for that address. Please enter a different address."
  end
end


