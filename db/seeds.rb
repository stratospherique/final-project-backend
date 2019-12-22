# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

(0..20).each do
  a = Article.new(
    description: Faker::Lorem.sentence(word_count: 3),
    price: Faker::Commerce.price(range: 400..2000.0),
    preview: [Faker::LoremPixel.image],
    buildingType: Faker::House.room,
    propertyType: Faker::House.room,
    city: Faker::Address.city,
    footage: Faker::Number.decimal(l_digits: 4, r_digits: 1),
    rating: Faker::Number.between(from: 0, to: 10)
  )
  p a.valid?
  a.save
end