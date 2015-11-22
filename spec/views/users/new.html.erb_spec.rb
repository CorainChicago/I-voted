require 'rails_helper'

feature "User creates new account" do
  scenario "user views page" do
    visit 'users/new'
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Email:")
    expect(page).to have_content("Password:")
    expect(page).to have_content("Street address:")
    expect(page).to have_content("City:")
    expect(page).to have_content("State:")
    expect(page).to have_content("Zip:")
  end
end
