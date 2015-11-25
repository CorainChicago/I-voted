require 'rails_helper'


feature "User creates new account" do
  background do
    User.create(:email => 'example@i-voted.com', :password => 'ivoted1', :street_address => '1600 Pennsylvania Ave', :city => 'Washington', :state => 'DC', :zip => '20500')
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
  it "user registers without password" do
    visit 'users/new'
      fill_in "user_zip", :with => '20500'
    click_button 'Register'
    expect(page).to have_content("Password can't be blank")
  end
end
