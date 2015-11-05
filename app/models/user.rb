class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true,
                       uniqueness: true
  has_many :favorites
  has_many :gifs, through: :favorites
end
