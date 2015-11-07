require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.new(username: 'Matt', password: 'password') }
  let(:admin) { User.new(username: 'admin', password: 'admin_password', role: 1) }

  it 'is valid' do
    expect(user).to be_valid
  end

  it 'is invalid without a username' do
    user.username = nil

    expect(user).not_to be_valid
  end

  it 'is invalid without a password' do
    user.password = nil

    expect(user).not_to be_valid
  end

  it 'is invalid without a 5+ character password' do
    user.password = '1234'

    expect(user).not_to be_valid
  end

  it 'is invalid without a unique username' do
    user.save
    expect(user).to be_valid

    new_user = User.new(username: 'Matt', password: 'password2')
    expect(new_user).not_to be_valid
  end

  it 'responds with its favorited gifs' do
    gif = Gif.create(image_path: 'sushicat.com/sushicat1',
                     category_id: 1)
    user.gifs << gif

    expect(user.gifs.map(&:image_path)).to eq(['sushicat.com/sushicat1'])
  end

  it 'is valid with an admin role' do
    expect(admin).to be_valid
  end
end
