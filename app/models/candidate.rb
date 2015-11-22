class Candidate < ActiveRecord::Base
  belongs_to :zipcode
  APPOINTED_OFFICES = ['U.S. Secretary', 'U.S. Attorney', 'Justice']
  CURRENT_PRESIDENT = "Barack Obama"
  def self.current_president
    CURRENT_PRESIDENT
  end
  def self.appointed_offices
    APPOINTED_OFFICES
  end
end
