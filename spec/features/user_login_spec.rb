require 'rails_helper'

RSpec.feature "User can login if they are registered", type: :feature, js: true do

  before :each do
    @user = User.create!(
      first_name: "Dani",
      last_name: "J",
      email: "testing@testing.com",
      password: "12345678",
      password_confirmation: "12345678"
    )
  end

  scenario "User can login" do
    visit root_path

    visit "/login"
    # save_screenshot

    fill_in "email", with: @user.email
    fill_in "password", with: @user.password

    click_button "Submit"

    expect(page).to have_content(@user.first_name)
  end
end
