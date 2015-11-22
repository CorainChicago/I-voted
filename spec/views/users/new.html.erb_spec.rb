require 'rails_helper'


feature "User creates new account" do
  background do
    User.new(:email => 'example@i-voted.com', :password => 'ivoted1', :street_address => '1600 Pennsylvania Ave', :city => 'Washington', :state => 'DC', :zip => '20500')
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
  scenario "user registers without password" do
    visit 'users/new'
    within("#new_user") do
      fill_in 'user_email', :with => 'example@i-voted.com'
      fill_in 'user_street_address', :with => '1600 Pennsylvania Ave'
      fill_in 'user_city', :with => 'Washington'
      fill_in 'user_state', :with => 'DC'
      fill_in 'user_zip', :with => '20500'
    end
    click_button 'Register'
    expect(page).to have_content("Password can't be blank")
  end
end
