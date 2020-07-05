require 'rails_helper'

RSpec.describe "Authentications", type: :request do

  let(:user) { create :valid_user }
  
  it "fails to authenticates a user using wrong username" do
    post login_path, params: {
      user: {
        username: 'users.co',
        password: 'sdqsaz'
      }
    }
    expect(response).to have_http_status(500)
    body = JSON.parse(response.body)
    expect(body['errors']).to include("no such user", "Please verify your credentials")
  end

  it 'fails to authenticate a user using a wrong pasword' do
    post login_path, params: {
      user: {
        username: user.username,
        password: 'sdqsaz'
      }
    }
    expect(response).to have_http_status(500)
    body = JSON.parse(response.body)
    expect(body['errors']).to include("no such user", "Please verify your credentials")
  end

  it 'authenticate a user using the right credentials' do
    post login_path, params: {
      user: {
        username: user.username,
        password: 'ass2grass'
      }
    }
    expect(response).to have_http_status(200)
    body = JSON.parse(response.body)
    expect(body['errors']).to be_nil
  end
  
end
