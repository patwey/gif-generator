require 'spec_helper'

describe "the login process", :type => :feature do
  before :each do
    User.create(username: "Sushicat", password: "password")
  end

  let(:login_user) do
    visit login_path
    fill_in "Username", with: "Sushicat"
    fill_in "Password", with: "password"
    click_button "Login"
  end

  it 'allows a registered user to login' do
    visit login_path
    fill_in "Username", with: "Sushicat"
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to have_content "Welcome back, Sushicat"
  end

  it 'does not allow an unregistered user to log in' do
    visit login_path
    fill_in "Username", with: "SushiDog"
    fill_in "Password", with: "ihatecats"
    click_button "Login"

    expect(page).not_to have_content "Welcome back, SushiDog"
    expect(page).to have_content "Invalid Login"
  end

  it 'does not allow a registered user to log in with the wrong password' do
    visit login_path
    fill_in "Username", with: "Sushicat"
    fill_in "Password", with: "ihatecats"
    click_button "Login"

    expect(page).not_to have_content "Welcome back, Sushicat"
    expect(page).to have_content "Invalid Login"
  end

  it 'does not allow a registered user to log in with the wrong username' do
    visit login_path
    fill_in "Username", with: "SushiDog"
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).not_to have_content "Welcome back, Sushicat"
    expect(page).to have_content "Invalid Login"
  end

  it 'allows an authenticated user to log out' do
    login_user

    expect(page).to have_content "Welcome back, Sushicat"

    click_link "Logout"

    expect(page).to have_content "Bye Sushicat"
  end

end
