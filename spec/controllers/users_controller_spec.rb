require 'rails_helper'

describe UsersController do

  describe "GET #new" do
    let!(:user) { User.create!(email: "cat12@cat.com", street_address: "39 Ada Lane", city: "Atlanta", state: "Alabama", zip: 34543, password: "1234" ) }
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    before(:each) do
      @params = {email: "cat@cat.com", street_address: "1246 Adams", city: "Atlanta", state: "Alabama", zip: 34543, password: "1234" }
    end
    context "when valid params are passed" do
      it "creates a new user" do
        expect{post :create, user:  { email: "cat@cat.com", street_address: "1246 Adams", city: "Atlanta", state: "Alabama", zip: 34543, password: "1234" }}.to change{User.all.count}.from(0).to(1)
      end
      it "finds the polling data for the user" do
        user_test = User.create( email: "cat@cat.com", street_address: "4434 N. Seeley", city: "Chicago", state: "IL", zip: 60625, password: "1234" )

        expect(@polling_place).to be nil
      end
    
      it "redirects to the user show page upon save" do
        post :create, user: { email: "cat@cat.com", street_address: "4434 N. Seeley", city: "Chicago", state: "IL", zip: 60625, password: "1234"}
        response.should redirect_to "http://test.host/users/#{User.last.id}"
      end
    end   
  end
end

