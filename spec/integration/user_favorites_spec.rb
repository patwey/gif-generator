require 'rails_helper'

describe 'the favoriting process', :type => :feature do
  before :each do
    category = Category.create(name: 'Sushicat')
    category.gifs.create(image_path: 'sushicat.io/sushicat')

    User.create(username: 'Pat', password: 'password')
    visit login_path
    fill_in 'Username', with: 'Pat'
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  it 'allows a user to favorite a gif' do
    pat = User.find_by(username: 'Pat')
    visit gifs_path


    within '.categories' do
      within '#Sushicat' do
        click_button 'Favorite'
      end
    end

    expect(pat.gifs.map(&:image_path)).to eq(['sushicat.io/sushicat'])
  end

  it 'does not allow a user to favorite the same gif twice' do
    pat = User.find_by(username: 'Pat')
    visit gifs_path

    within '.categories' do
      within '#Sushicat' do
        click_button 'Favorite'
      end
    end

    within '.categories' do
      within '#Sushicat' do
        expect(page).not_to have_content 'Favorite'
      end
    end
  end
end
