require 'rails_helper'

describe "the account creation process", :type => :feature do
  it "creates an account with valid username and password" do
    visit new_user_path

    fill_in 'Username', with: 'Pat'
    fill_in 'Password', with: 'sushicat'
    click_button 'Create Account'

    expect(page).to have_content "Welcome, Pat. Get your GIF on! #SUSHICAT"
  end

  it "does not create account with invalid username" do
    visit new_user_path

    fill_in 'Username', with: nil
    fill_in 'Password', with: 'sushicat'
    click_button 'Create Account'

    expect(page).to have_content "Valid username and password required."
  end

  it "does not create account with short password" do
    visit new_user_path

    fill_in 'Username', with: 'Pat'
    fill_in 'Password', with: '1234'
    click_button 'Create Account'

    expect(page).to have_content "Valid username and password required."
  end

end
