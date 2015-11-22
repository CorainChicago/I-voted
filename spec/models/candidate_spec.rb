require 'rails_helper'

describe Candidate do
  let (:candidate) {Candidate.create(:name => 'John Smith', :office => 'Governor of Virginia', :party_affiliation => 'Whig')}
  it "should have a name" do
    name = "John Smith"
    expect(candidate.name).to eq(name)
  end
  it "should have an office" do
    office = "Governor of Virginia"
    expect(candidate.office).to eq(office)
  end
  it "should have a party affiliation" do
    party_affiliation = "Whig"
    expect(candidate.party_affiliation).to eq(party_affiliation)
  end
  it "should have a current_president method" do
    CURRENT_PRESIDENT = "Barack Obama"
    expect(Candidate.current_president).to eq(CURRENT_PRESIDENT)
  end
end
