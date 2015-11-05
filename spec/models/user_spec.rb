require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.new(username: 'Matt', password: 'password') }

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

  it 'is invalid without a unique username' do
    user.save
    expect(user).to be_valid

    new_user = User.new(username: 'Matt', password: 'password2')
    expect(new_user).not_to be_valid
  end

  it 'responds with its favorited gifs' do
    gif = Gif.create(title: 'Sushi Cat',
                     image_path: 'sushicat.com/sushicat1',
                     category_id: 1)
    user.gifs << gif

    expect(user.gifs.map(&:title)).to eq(['Sushi Cat'])
  end
end
