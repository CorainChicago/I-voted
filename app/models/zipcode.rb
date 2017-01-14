class Zipcode < ActiveRecord::Base
  require 'net/http'
  require 'json'
  require 'csv'

  def self.make_zipcode_object(zip_string)
    zip_file = 'db/zipcodes/us_postal_codes_all_zips.csv'
    
    Rails.cache.fetch("zip_hash#{Time.now.strftime('%U').to_s}#{Time.now.year.to_s}") do
      zip_codes = {}
      CSV.foreach(zip_file) do |row|
        zip_codes[row[0]] = [row[2], row[3]]
      end
    end

    target_zip_info = zip_codes[zip_string]
    new(zip: zip_string, state_name: target_zip_info[0], abbreviation: target_zip_info[1])
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


