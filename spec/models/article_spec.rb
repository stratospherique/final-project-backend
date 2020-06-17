require 'rails_helper'
require 'faker'

RSpec.describe Article, type: :model do
  context 'when adding and article' do
    let(:article) { Article.new }
    let(:errors_count) { 10 }
    let(:author) {create :author}

    it 'creates an invalid Real estate without attributes' do
      expect(article).to be_invalid
      expect(article.errors.full_messages.size).to eq(errors_count)
    end

    it 'checks if a valid description is entered' do
      expect(article).to be_invalid
      expect(article.errors.full_messages).to include("Description can't be blank",
                                                      'Description is too short (minimum is 10 characters)')
      article.description = '2 bedrooms 1 bathroom'
      expect(article).to be_invalid
      expect(article.errors.full_messages).not_to include("Description can't be blank",
                                                          'Description is too short (minimum is 10 characters)')
    end

    it 'checks if a valid price is entered' do
      expect(article).to be_invalid
      expect(article.errors.full_messages).to include('Price is not a number')
      article.price = 544
      expect(article).to be_invalid
      expect(article.errors.full_messages).not_to include('Price is not a number')
    end

    it 'checks if a preview is entered' do
      expect(article).to be_invalid
      expect(article.errors.full_messages).to include("Preview can't be blank")
      article.preview = [Faker::LoremPixel.image(category: 'city', number: 1)]
      expect(article).to be_invalid
      expect(article.errors.full_messages).not_to include("Preview can't be blank")
    end

    it 'checks if a valid building type is entered' do
      expect(article).to be_invalid
      expect(article.errors.full_messages).to include("Buildingtype can't be blank")
      article.buildingType = Faker::House.room
      expect(article).to be_invalid
      expect(article.errors.full_messages).not_to include("Buildingtype can't be blank")
    end

    it 'checks if a valid property type is entered' do
      expect(article).to be_invalid
      expect(article.errors.full_messages).to include("Propertytype can't be blank")
      article.propertyType = Faker::House.room
      expect(article).to be_invalid
      expect(article.errors.full_messages).not_to include("Propertytype can't be blank")
    end

    it 'checks if a valid city is entered' do
      expect(article).to be_invalid
      expect(article.errors.full_messages).to include('City is too short (minimum is 4 characters)')
      article.city = Faker::Address.city
      expect(article).to be_invalid
      expect(article.errors.full_messages).not_to include('City is too short (minimum is 4 characters)')
    end

    it 'checks if a valid footage is entered' do
      expect(article).to be_invalid
      expect(article.errors.full_messages).to include('Footage is not a number')
      article.footage = Faker::Number.decimal(l_digits: 4, r_digits: 1)
      expect(article).to be_invalid
      expect(article.errors.full_messages).not_to include('Footage is not a number')
    end

    it 'checks if a valid rating is entered' do
      expect(article).to be_invalid
      expect(article.errors.full_messages).to include('Rating is not included in the list')
      expect(article).to be_invalid
      article.rating = Faker::Number.between(from: 0, to: 5)
      expect(article).to be_invalid
      expect(article.errors.full_messages).not_to include('Rating is not included in the list')
    end

    it 'checks if an autohor is entered' do
      expect(article).to be_invalid
      expect(article.errors.full_messages).to include('Author must exist')
      expect(article).to be_invalid
      article.author = author
      expect(article).to be_invalid
      expect(article.errors.full_messages).not_to include('Author must exist')
    end

    it 'create an valid Real estate with multiple attributes' do
      article.description = '2 bedrooms 1 bathroom'
      article.price = 544
      article.preview = [Faker::LoremPixel.image(category: 'city', number: 1)]
      article.buildingType = Faker::House.room
      article.propertyType = Faker::House.room
      article.city = Faker::Address.city
      article.footage = Faker::Number.decimal(l_digits: 4, r_digits: 1)
      article.rating = Faker::Number.between(from: 0, to: 5)
      article.author = author
      expect(article).to be_valid
      expect(article.errors.full_messages).to eq([])
    end
  end

  context 'When deleting an article' do
    it 'deletes an article' do
      exp = create :articles
      expect(Article.count).to eq(1)
      exp.destroy
      expect(Article.count).to eq(0)
    end
  end

end