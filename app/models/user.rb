class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true,
                       uniqueness: true
  validates :password, length: { minimum: 5 }
  has_many :favorites
  has_many :gifs, through: :favorites

  enum role: %w(default admin)
end
