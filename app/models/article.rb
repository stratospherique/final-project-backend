class Article < ApplicationRecord

  has_many :favorites
  has_many :users, :through => :favorites

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
