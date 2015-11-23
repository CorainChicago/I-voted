require 'rails_helper'

describe Zipcode do
  it "has a get_polling_place method that accepts an address as an argument" do
    zipcode = class_double(Zipcode)
    address = '123 Main St Anywhere, IL 60612'
    expect(zipcode).to receive(:get_polling_place).with(address)
    zipcode.get_polling_place(address)
  end

  it "has a get_district method that accepts an address as an argument" do
    zipcode = class_double(Zipcode)
    address = '123 Main St Anywhere, IL 60612'
    expect(zipcode).to receive(:get_district).with(address)
    zipcode.get_district(address)
  end
end
