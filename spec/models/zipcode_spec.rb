require 'rails_helper'

describe Zipcode do
  xit "should have many candidates" do
    zipcode = Zipcode.reflect_on_association(:candidates)
    expect(zipcode.macro).to eq(:has_many)
  end
end
