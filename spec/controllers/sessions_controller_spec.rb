require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #create" do

    context "not valid without credentials" do
      controller do
        def create
          render :text => "index called", :status => :bad_gateway
        end
      end
      it "returns an error message when trying to create without info" do
        get :create
        expect(response).to have_http_status("502")
      end
    end

    context "with valid credentials" do
      let :credentials do
        { email: "cat@cat.com", street_address: "1246 Adams", city: "Atlanta", state: "Alabama", zip: 34543 }
      end
      let :user do
        FactoryGirl.create(:user, credentials)

      get :create
        expect(response).to have_http_status(:success)
      end
    end

  end
end


 describe "destroy"  do

    context "when valid params are passed" do
      it "creates a new Game" do
        expect {
        post :create, {game: {user_throw: "paper-plane"}}
      }.to change(Game, :count).by(+1)
      end

      it "assigns a newly created game as @game" do
        post :create, {game: {user_throw: "paper-plane"}}
        expect(assigns(:game)).to be_instance_of(Game)
      end

      it "redirects to the created game"  do
        post :create, {game: {user_throw: "paper-plane"}}
        expect(response).to redirect_to game_path(Game.last.id)
      end
    end