class Article < ApplicationRecord

  has_many :favorites
  has_many :likers, :through => :favorites, class_name: 'User'
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  validates :description, presence: true, length: {maximum: 50, minimum: 10}
  validates :price, numericality: true
  validates :preview, presence: true
  validates :buildingType, presence: true, length: {maximum: 20}
  validates :propertyType, presence: true, length: {maximum: 20}
  validates :city, length: {minimum: 4}
  validates :footage, numericality: true
  validates :rating, inclusion: {in: 0..5}

  scope :ordered, -> {Article.order(rating: :desc, created_at: :desc)}
  scope :trending, -> {ordered.limit(5).ids}
  scope :not_trending, -> {ordered.offset(6)}
end
