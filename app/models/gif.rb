class Gif < ActiveRecord::Base
  validates :title, presence: true,
                    uniqueness: true
  validates :image_path, presence: true,
                         uniqueness: true
  validates :category_id, presence: true
  has_many :favorites
  has_many :users, through: :favorites
end
