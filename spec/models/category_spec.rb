require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.new(name: 'Sushicat') }

  it 'is valid' do
    expect(category).to be_valid
  end

  it 'is invalid without a name' do
    category.name = nil

    expect(category).not_to be_valid
  end

  it 'is invalid without a unique name' do
    category.save
    new_category = Category.new(name: 'Sushicat')

    expect(new_category).not_to be_valid
  end

  it 'responds with its gifs' do
    category.save
    category.gifs.create(image_path: 'sushicat.io/sushicat')

    expect(category.gifs.map(&:image_path)).to eq(['sushicat.io/sushicat'])
  end
end
