class User < ApplicationRecord
  has_secure_password
  # for user avatar
  has_one_attached :avatar

  has_many :favorites
  has_many :articles, :through => :favorites


  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 4 }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  # validate if the passed file is an image
end
