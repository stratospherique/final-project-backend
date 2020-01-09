require 'rails_helper'
require 'faker'

RSpec.describe Article, type: :model do
  let(:article) {Article.new}
  let(:errors_count) {9}

  it 'creates an invalid Real estate without attributes' do
    expect(article).to be_invalid
    expect(article.errors.full_messages.size).to eq(errors_count)
  end

  

  it 'create an valid Real estate with multiple attributes' do
    article.description = '2 bedrooms 1 bathroom'
    expect(article).to be_invalid
    expect(article.errors.full_messages.size).to be < errors_count
    article.price = 544
    expect(article).to be_invalid
    article.preview = [Faker::LoremPixel.image(category: 'city', number: 1)]
    expect(article).to be_invalid
    article.buildingType = Faker::House.room
    expect(article).to be_invalid
    article.propertyType = Faker::House.room
    expect(article).to be_invalid
    article.city = Faker::Address.city
    expect(article).to be_invalid
    article.footage = Faker::Number.decimal(l_digits: 4, r_digits: 1)
    expect(article).to be_invalid
    article.rating = Faker::Number.between(from: 0, to: 5)
    expect(article).to be_valid
    expect(article.errors.full_messages).to eq([])
  end

end