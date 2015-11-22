require 'rails_helper'


feature "User creates new account" do
  background do
    User.make(:email => 'example@i-voted.com', :password => 'ivoted1', :street_address => '1600 Pennsylvania Ave', :city => 'Washington', :state => 'DC', :zip => '20500')
  end

  scenario "page loads correctly" do
    visit 'users/new'
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Email:")
    expect(page).to have_content("Password:")
    expect(page).to have_content("Street address:")
    expect(page).to have_content("City:")
    expect(page).to have_content("State:")
    expect(page).to have_content("Zip:")
  end
  scenario "user registers with improperly formatted email" do
    visit 'users/new'
    within("#user") do
      fill_in "Email:" :with => 'example@i-voted'
      fill_in "Password:" :with => 'ivoted1'
      fill_in "Street address:" :with => '1600 Pennsylvania Ave'
      fill_in "City:" :with => 'Washington'
      fill_in "State:" :with => 'DC'
      fill_in "Zip:" :with => '20500'
    end
    click_button 'Register'
    expect(page).to have_content("Email is invalid")
    end
  end

end
