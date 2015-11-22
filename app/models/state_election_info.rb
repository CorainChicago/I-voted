class StateElectionInfo < ActiveRecord::Base
  after_create :remove_duplicates

  private
  def remove_duplicates
    self.destroy if StateElectionInfo.where(election_title: self.election_title).count > 1
  end
end
