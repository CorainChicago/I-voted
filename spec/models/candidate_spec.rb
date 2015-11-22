require 'rails_helper'

describe Candidate do
  let (:candidate) {Candidate.new(:name => 'John Smith', :office => 'Governor of Virginia', :party_affiliation => 'Whig')}
  it "should have a name" do
    expect(candidate.name).to be('John Smith')
  end
end
