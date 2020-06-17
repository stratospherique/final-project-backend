require 'rails_helper'

RSpec.describe "Favorites", type: :request do
    describe 'Create a favorite record #create' do

        let(:liker) {create :valid_user}
        let(:article) {create :articles}

        context 'User is logged in' do
            before(:each) do
                post login_path, params: {
                    user: {
                        username: liker.username,
                        password: 'ass2grass'
                    }
                }
            end
            it 'fails create a favorite when wrong params were given' do
                post favorites_path, params: {
                    favorite: {
                        user_id: 200,
                        article_id: 200,
                    }
                }
                expect(response).to have_http_status(500)
                json = JSON.parse(response.body)
                expect(json['message']).to include("Liker must exist", "Liked article must exist")
            end
    
            
            it 'creates a favorites when valid params is given' do
                post favorites_path, params: {
                    favorite: {
                        user_id: liker.id,
                        article_id: article.id,
                    }
                }
                expect(response).to have_http_status(200)
                json = JSON.parse(response.body)
                expect(json).to eql(article.id)
            end
        end

        context 'User in not logged in' do
            it 'fails to create a favorite if user not logged in' do
                post favorites_path, params: {
                    favorite: {
                        user_id: liker.id,
                        article_id: article.id,
                    }
                }
                expect(response).to have_http_status(404)
                json = JSON.parse(response.body)
                expect(json['message']).to include("not authorized action")
            end
        end
      
    end
end
