require 'rails_helper'

describe 'the gifs view', :type => :feature do

  it 'has an index that shows all gifs sorted by category' do
    sushicat = Category.create(name: 'Sushicat')
    sushicat.gifs.create(image_path: 'sushicat.io/sushicat')

    piglet = Category.create(name: 'Piglet')
    piglet.gifs.create(image_path: 'winniethepoo.org/piglet')

    visit '/gifs'

    within('.categories') do
      expect(page).to have_content('Sushicat')
      expect(page).to have_content('Piglet')
    end
  end
end
