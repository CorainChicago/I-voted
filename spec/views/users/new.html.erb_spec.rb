require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :view do
  scenario "user creates new account" do
    visit 'users/new'
    expect(page).to have_content("Sign Up")
    expect(page).has_field("Email:" :type => :email )
    expect(page).to have_content("Password:")
    expect(page).to have_content("Street address:")
    expect(page).to have_content("City:")
    expect(page).to have_content("State:")
    expect(page).to have_content("Zip:")
  end

  # scenario "registration page is distinct from login" do
  #   visit 'users/new'
  #
  # end
end
