require 'rails_helper'

RSpec.describe Favorite, type: :model do
  context 'Creating a favorites' do
    it 'creates a favorite article' do
      fav = build :favorite
      expect(fav.class).to be(Favorite)
    end

    it 'creates an invalid favorite' do
      fav = build :favorite
      expect(fav).to be_invalid
      expect(fav.errors.full_messages).to include("Liker must exist", "Liked article must exist")
    end

    it 'checks if the favorite is linked to a user' do
      fav = build :favorite
      user = create :valid_user
      fav.liker = user
      expect(fav).to be_invalid
      expect(fav.errors.full_messages).not_to include('Liker must exist')
    end

    it 'checks if the favorite is linked to an article' do
      fav = build :favorite
      article = create :articles
      fav.liked_article = article
      expect(fav).to be_invalid
      expect(fav.errors.full_messages).not_to include('Liked article must exist')
    end

    it 'creates a valid favorites' do
      fav = build :favorite
      article = create :articles
      fav.liked_article = article
      user = create :valid_user
      fav.liker = user
      expect(fav).to be_valid
    end
  end
end