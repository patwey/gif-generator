class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.string :title
      t.string :image_path
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
