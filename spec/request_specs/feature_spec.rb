# frozen_string_literal: true

require 'rails_helper'

# frozen_string_literal: true

RSpec.describe 'Features', type: :request do
  describe 'GET #get_favorites_ids' do

    let(:user) {create :valid_user}

    it 'returns an error if user is not logged in' do
      get "/user/#{user.id}/favorites"
      expect(response).to have_http_status(500)
      expect(JSON.parse(response.body)['error']).to eq('Unauthorized action')
    end

    it 'returns an error if user is unregistered' do
      begin
        get "/user/10/favorites"
      rescue => exception
        expect(exception.class).to eq(ActiveRecord::RecordNotFound)        
      end
    end

    it 'returns an empty list of liked articles for a user' do
      post '/login', params: {user: {username: user.username, password: 'ass2grass'} }
      get "/user/#{user.id}/favorites"
      expect(JSON.parse(response.body)).to be_empty
    end

    it 'returns the list of liked articles for a user' do
      post '/login', params: {user: {username: user.username, password: 'ass2grass'} }
      article = create :articles
      fav_relation = build :favorite
      fav_relation.user_id = user.id
      fav_relation.article_id = article.id
      fav_relation.save
      get "/user/#{user.id}/favorites"
      expect(JSON.parse(response.body)).to include(article.id)
    end
  end
end