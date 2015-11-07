require 'rails_helper'

describe "the gif admin process", type: :feature do

  let(:admin) {  admin = User.create(username: "Admin",
                        password: "admin_password",
                        role: 1) }

  let(:user) {    user = User.create(username: "Matt",
                                     password: "password",
                                     role: 0 ) }

  it 'allows a logged in admin to see the gifs index' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_gifs_path

    expect(page).to have_content "All Gifs"
  end

  it 'does not allow a regular user to see admin gifs index' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit admin_gifs_path

    expect(page).not_to have_content "All Gifs"
    expect(page).to have_content "The page you were looking for doesn't exist"
  end

  it 'allows a logged in admin to add a gif to the database' do
    
  end

end
