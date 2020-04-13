# frozen_string_literal: true

FactoryBot.define do
  factory :articles, class: Article do
    description {'2 bedrooms 1 bathroom'}
    price {544}
    preview {[Faker::LoremPixel.image(category: 'city', number: 1)]}
    buildingType {Faker::House.room}
    propertyType {Faker::House.room}
    city {Faker::Address.city}
    footage {Faker::Number.decimal(l_digits: 4, r_digits: 1)}
    rating {Faker::Number.between(from: 0, to: 5)}
  end
end