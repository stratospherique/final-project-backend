class User < ApplicationRecord
  # add a default attachment for avatar if empty
  after_commit :attach_avatar, only: [:save]

  has_secure_password
  # for user avatar
  has_one_attached :avatar

  has_many :favorites, dependent: :destroy
  has_many :liked_articles, :through => :favorites, class_name: 'Article'
  has_many :articles, dependent: :destroy


  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 4 }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  # validate if the passed file is an image

  private

  def attach_avatar
    if !self.avatar.attached?
      file = open('https://res.cloudinary.com/ddx20vuxl/image/upload/v1586894678/user_utwpej.png')
      self.avatar.attach(io: file, filename: 'user.png', content_type: 'image')
    end
  end
end
