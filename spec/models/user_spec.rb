require 'rails_helper'


describe "User" do
  describe "validations" do
    it "is not valid without email" do
      user = User.create
      user.valid?
      expect(user.errors).to_not be_empty
  end

    it "is not valid without street address" do
      user = User.create(email: "myemail@gmail.com")
      user.valid?
      expect(user.errors).to_not be_empty
    end

    it "is not valid without city" do
      user = User.create(email: "myemail@gmail.com", street_address: " 351 W Hubbard" )
      user.valid?
      expect(user.errors).to_not be_empty
    end

    it "is not valid without state" do
      user = User.create(email: "myemail@gmail.com", street_address: " 351 W Hubbard", city: "SM" )
      user.valid?
      expect(user.errors).to_not be_empty
    end
    it "is not valid without password" do
      user = User.create(email: "myemail@gmail.com", street_address: " 351 W Hubbard", city: "SM", state: "CA" )
      user.valid?
      expect(user.errors).to_not be_empty
    end

    it "should be valid" do
      user = User.new(email: "myemail@gmail.com", street_address: " 351 W Hubbard", city: "SM", state: "CA", password: "password")
      user.valid?
      expect(user.errors).to_not be_empty
    end
  end
end
