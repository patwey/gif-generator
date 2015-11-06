class RemoveTitleFromGifs < ActiveRecord::Migration
  def change
    remove_column :gifs, :title
  end
end
