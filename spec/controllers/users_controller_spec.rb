require 'rails_helper'

describe UsersController do

  describe "GET #new" do
    let!(:User) { User.create!(email: "cat12@cat.com", street_address: "39 Ada Lane", city: "Atlanta", state: "Alabama", zip: 34543, password: "1234" ) }
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "when valid params are passed" do
      it "creates a new user" do
        expect{post :create, user:  { email: "cat@cat.com", street_address: "1246 Adams", city: "Atlanta", state: "Alabama", zip: 34543, password: "1234" }}.to change{User.all.count}.from(0).to(1)
      end
    end   
  end
end

