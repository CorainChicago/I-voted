class Candidate < ActiveRecord::Base
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

  def self.remove_appointed_politicians(zip)
    APPOINTED_OFFICES.each do |office|

      Candidate.where(zip: zip).where('office LIKE ?', "%#{office}%").destroy_all

    end
  end
end
