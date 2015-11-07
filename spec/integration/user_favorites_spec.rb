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

  let(:favorite_sushicat) do
    visit gifs_path

    within '.categories' do
      within '#Sushicat' do
        click_button 'Favorite'
      end
    end
  end

  it 'allows a user to favorite a gif' do
    pat = User.find_by(username: 'Pat')

    favorite_sushicat

    expect(pat.gifs.map(&:image_path)).to eq(['sushicat.io/sushicat'])
  end

  it 'does not allow a user to favorite the same gif twice' do
    pat = User.find_by(username: 'Pat')

    favorite_sushicat

    within '.categories' do
      within '#Sushicat' do
        expect(page).not_to have_content 'Favorite'
      end
    end
  end

  it 'allows users to see their favorited gifs' do
    category = Category.create(name: 'Piglet')
    category.gifs.create(image_path: 'winniethepooh.org/piglet')

    pat = User.find_by(username: 'Pat')

    favorite_sushicat

    within '#Piglet' do
      click_button 'Favorite'
    end

    visit user_path pat

    within '.favorites' do
      expect(page).to have_content 'Sushicat'
      expect(page).to have_content 'Piglet'
    end
  end

  it 'allows users to unfavorite their favorited gifs' do
    pat = User.find_by(username: 'Pat')

    favorite_sushicat

    visit user_path pat

    within '.favorites' do
      expect(page).to have_content 'Sushicat'
      click_button 'Unfavorite'
    end

    expect(current_path).to eq(user_path pat)
    expect(page).not_to have_content 'Sushicat'
  end
end
