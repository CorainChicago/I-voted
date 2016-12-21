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

  it "returns a polling location for a location" do 
    expect(Zipcode.get_polling_place('1505 W Wilson, Chicago, IL 60640')['address']['locationName']).to eq("GERMAN SCHOOL OF CHICAGO")
  end
end

describe "#get_district" do
  it "returns a disctrict" do 
    address = "4432 N. Seeley, Chicago, IL"
    response = Zipcode.get_district(address)
    expect(response).to eq("Illinois's 5th congressional district")
  end
end
