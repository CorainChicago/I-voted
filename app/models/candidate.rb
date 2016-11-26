class Candidate < ActiveRecord::Base

  require 'curb'
  require 'json'

  belongs_to :zipcode
  APPOINTED_OFFICES = ['U.S. Secretary', 'U.S. Attorney', 'Justice', 'Vice']
  CURRENT_PRESIDENT = "Barack Obama II"
  def self.current_president
    CURRENT_PRESIDENT
  end

  def self.get_offices(candidates)
    offices = []
    candidates.each do |candidate|
      offices << candidate[:office]
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

  def self.candidates_in_given_office(candidates, office)
    candidate_list = []
    candidates.each do |candidate|
      candidate_list << candidate if candidate[:office] == office
    end
    
    candidate_list
  end

  def self.remove_appointed_politicians_and_current_president(candidates)
    APPOINTED_OFFICES.each do |office|
      candidates.delete_if{ |candidate| candidate[:office].include?(office) || candidate[:name] == current_president}
    end
    candidates
  end
end
