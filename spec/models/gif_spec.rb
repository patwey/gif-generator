require 'rails_helper'

RSpec.describe Gif, type: :model do

  let(:gif) { Gif.new(title: "sushicat",
                      image_path: "image/path",
                      category_id: 1) }

  it 'is valid' do
    expect(gif).to be_valid
  end

  it 'is invalid without a title' do
    gif.title = nil

    expect(gif).not_to be_valid
  end

  it 'is invalid without a image_path' do
    gif.image_path = nil

    expect(gif).not_to be_valid
  end

  it 'is invalid without a category_id' do
    gif.category_id = nil

    expect(gif).not_to be_valid
  end

  it 'is invalid without a unique title' do
    expect(gif).to be_valid
    gif.save

    new_gif = Gif.new(title: "sushicat", image_path: "age/path", category_id: 1)

    expect(new_gif).not_to be_valid
  end

  it 'is invalid without a unique image_path' do
    expect(gif).to be_valid
    gif.save

    new_gif = Gif.new(title: "sushicat2", image_path: "image/path", category_id: 1)

    expect(new_gif).not_to be_valid
  end

  it 'responds to users' do
    user = User.create(username: 'Pat', password: 'sushicats!!!')

    gif.users << user

    expect(gif.users.map(&:username)).to eq(["Pat"])
  end

end
