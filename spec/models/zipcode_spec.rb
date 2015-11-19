require 'rails_helper'

describe Zipcode do
  it "should have many candidates" do
    zipcode = Zipcode.reflect_on_association(:candidates)
    expect(zipcode.macro).to eq(:has_many)
  end
end
