class Candidate < ActiveRecord::Base

  require 'curb'
  require 'json'

  belongs_to :zipcode
  APPOINTED_OFFICES = ['U.S. Secretary', 'U.S. Attorney', 'Justice']
  CURRENT_PRESIDENT = "Barack Obama"
  def self.current_president
    CURRENT_PRESIDENT
  end

  def self.get_offices(candidates)
    offices = []
    candidates.each do |candidate|
      offices << candidate.office
    end
    offices.uniq
  end

  def self.query_for_candidates(zip)
    candidates_string = Curl.get('https://votesmart.org/x/search?s=' + zip)
    candidates_json = JSON.parse(candidates_string.body_str)['results']
    candidates = []

    candidates_json.each do |candidate|
      candidates.push({
        name: candidate['name'],
        office: candidate['office'],
        party_affiliation: candidate['party'], 
        zip: zip
      })
    end if candidates_json.present?

    candidates
  end

  def self.remove_appointed_politicians(zip)
    APPOINTED_OFFICES.each do |office|

      Candidate.where(zip: zip).where('office LIKE ?', "%#{office}%").destroy_all

    end
  end
end
