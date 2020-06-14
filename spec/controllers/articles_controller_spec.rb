require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  let(:user) {create :valid_user}

  describe 'GET #index' do
    it 'returns empty list of articles if no articles were created' do
      get :index
      expect(response).to have_http_status(500)
      json = JSON.parse(response.body)
      expect(json['articles']).to be_nil
    end

    it 'returns a list of articles if no articles were created' do
      article = create :articles
      get :index
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['articles']).not_to be_nil
      expect(json['articles'].class).to be(Array)
      expect(json['articles'].first['id']).to be(article.id)
    end
  end

  describe 'POST #create' do
    it 'fails to create an article if params were empty' do
      post :create, params: {article: {
        description: nil,
        price: nil,
        buildingType: nil,
        propertyType: nil,
        city: nil,
        footage: nil,
        rating: nil}}
        json = JSON.parse(response.body)
        expect(response).to have_http_status(500)
        expect(json['message']).to include("Description can't be blank",
                                           "Price is not a number",
                                           "Buildingtype can't be blank",
                                           "Propertytype can't be blank",
                                           "City is too short (minimum is 4 characters)",
                                           "Footage is not a number",
                                           "Rating is not included in the list")
    end

    it 'fails to create an article if used not signed in' do
      
    end

    it 'creates an article' do
      post :create, params: {article: {
        description: '2 bedrooms, 1 kitchen',
        price: 444,
        buildingType: 'appartment',
        propertyType: 'lease',
        city: 'Monaco',
        footage: 156,
        rating: 4}}
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(json['article'].id).to eq(Article.last.id)
    end
  end

  describe 'GET #find_trending' do
    it 'returns an array of 5 most liked articles' do
      articles = (0..10).map do
        create :articles
      end 
      get :find_trending
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['message']).to be_nil
      expect(json['trending'].size).to eq(5)
    end

    it 'returns an empty list of trending articles' do
      get :find_trending
      expect(response).to have_http_status(500)
      json = JSON.parse(response.body)
      expect(json['message']).not_to be_nil
      expect(json['trending']).to be_nil
    end
  end
end
