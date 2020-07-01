require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:user) {create :valid_user}
  
  describe 'GET #index' do
    it 'returns empty list of articles if no articles were created' do
      get articles_path
      expect(response).to have_http_status(500)
      json = JSON.parse(response.body)
      expect(json['articles']).to be_nil
    end
     it 'returns a list of articles if no articles were created' do
      article = create :articles
      get articles_path
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['articles']).not_to be_nil
      expect(json['articles'].class).to be(Array)
      expect(json['articles'].first['id']).to be(article.id)
    end
  end

  describe 'GET #find_trending' do
    it 'returns an array of 5 most liked articles' do
      articles = (0..10).map do
        create :articles
      end 
      get articles_trending_path
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['message']).to be_nil
      expect(json['trending'].size).to eq(5)
    end
     it 'returns an empty list of trending articles' do
      get articles_trending_path
      expect(response).to have_http_status(500)
      json = JSON.parse(response.body)
      expect(json['message']).not_to be_nil
      expect(json['trending']).to be_nil
    end
  end

  describe 'POST #create' do
    context 'User is logged in' do
      before(:each) do
        post login_path, params: {
                      user: {
                          username: user.username,
                          password: 'ass2grass'
                      }
                  }
      end

      after(:each) do
        delete logout_path     
      end

      it 'fails to create an article if params were empty' do
        post '/articles', params: {article: {
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
                                             "Rating is not included in the list",
                                             "Preview can't be blank")
      end
  
      it 'creates an article' do
        post '/articles', params: {article: {
          description: '2 bedrooms, 1 kitchen',
          price: 444,
          buildingType: 'appartment',
          propertyType: 'lease',
          preview: [Faker::LoremPixel.image(category: 'city', number: 1)],
          city: 'Monaco',
          footage: 156,
          rating: 4}}
          json = JSON.parse(response.body)
          expect(response).to have_http_status(:success)
      end
    end
  

    context 'User is not logged in' do
      it 'fails to create an article for a non logged in user' do
        post '/articles', params: {article: {
          description: nil,
          price: nil,
          buildingType: nil,
          propertyType: nil,
          city: nil,
          footage: nil,
          rating: nil}}
          json = JSON.parse(response.body)
          expect(response).to have_http_status(404)
      end
  
      it 'fails to create an article  for a non logged in user' do
        post '/articles', params: {article: {
          description: '2 bedrooms, 1 kitchen',
          price: 444,
          buildingType: 'appartment',
          propertyType: 'lease',
          city: 'Monaco',
          footage: 156,
          rating: 4}}
          json = JSON.parse(response.body)
          expect(response).to have_http_status(404)
      end
      end
    end

    describe 'Articles deletion' do
      let(:article) { create :creation_article }
      let(:random_article) { create :articles }
      let(:admin_user) { create :admin_user }
      context 'When user is logged in (not admin)' do
        before(:each) do
          post login_path, params: {
                        user: {
                            username: article.author.username,
                            password: 'ass2grass'
                        }
                    }
        end

        after(:each) do
          delete logout_path   
        end

        it 'deletes an article if a correct params were passed' do
          expect {
            delete "/articles/#{article.id}"
          }.to change(article.author.articles, :count)
          expect(response).to have_http_status(200)
        end

        it 'fails to delete an article if a wrong params were passed' do
          expect {
            delete "/articles/#{777}"
          }.not_to change(article.author.articles, :count)
          expect(response).to have_http_status(500)
        end

        it 'fails to delete an articles if the user is not the author' do
          expect {
            delete "/articles/#{random_article.id}"
          }.not_to change(article.author.articles, :count)
          expect(response).to have_http_status(500)
        end
      end

      context 'When user is logged in (admin)' do
        before(:each) do
          post login_path, params: {
                        user: {
                            username: admin_user.username,
                            password: 'ass2grass'
                        }
                    }
        end

        after(:each) do
          delete logout_path   
        end

        it 'deletes an article if a correct params were passed' do
          the_art = article
          expect {
            delete "/articles/#{the_art.id}"
          }.to change(Article, :count)
          expect(response).to have_http_status(200)
        end

        it 'fails to delete an article if a wrong params were passed' do
          expect {
            delete "/articles/#{777}"
          }.not_to change(Article, :count)
          expect(response).to have_http_status(500)
        end

        it 'deletes an articles if the user is not the author but is admin' do
          expect {
            delete "/articles/#{random_article.id}"
          }.not_to change(Article, :count)
          expect(response).to have_http_status(200)
        end
      end

      context 'when user in not logged in' do
        it 'prevents an no logged user from deleting an article' do
          expect {
            delete "/articles/#{article.id}"
          }.not_to change(article.author.articles, :count)
          expect(response).to have_http_status(404)
        end
      end
    end
end
