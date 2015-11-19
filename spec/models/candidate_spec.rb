require 'rails_helper'


describe Candidate do
  it "should belong to Zipcode" do
    candidate = Candidate.reflect_on_association(:zipcode)
    expect(candidate.macro).to eq(:belongs_to)
  end
end
