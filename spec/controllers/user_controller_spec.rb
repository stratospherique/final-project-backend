# frozen_string_literal: true

require 'rails_helper'

# controller specs

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'return list users' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    it 'creates a user if valid paramaters were passed' do
      post :create, params: {user: {username: 'alex', email: 'alex@goosd.com', password: 'ab12cd34', password_confirmation: 'ab12cd34'}}
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(parsed_response['user']['id']).to eq(User.last.id)
    end

    it 'fails to create a user if no paramaters were passed' do
      post :create, params: {user: {username: nil, email: nil, password: nil, password_confirmation: nil}}
      expect(response).to have_http_status(500)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors']).to include("Username can't be blank")
      expect(parsed_response['errors']).to include("Username is too short (minimum is 4 characters)")
      expect(parsed_response['errors']).to include("Password can't be blank")
      expect(parsed_response['errors']).to include("Email can't be blank")
      expect(parsed_response['errors']).to include("Email is invalid")
    end

    it "fails to create a user if passwords don't match" do
      post :create, params: {user: {username: 'alex', email: 'alex@goosd.com', password: 'ab12cd34', password_confirmation: '1122121'}}
      expect(response).to have_http_status(500)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors']).to include("Password confirmation doesn't match Password")
    end

    it 'creates a user with a default avatar image attachement even if no image were passed' do
      post :create, params: {user: {username: 'alex', email: 'alex@goosd.com', password: 'ab12cd34', password_confirmation: 'ab12cd34'}}
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(User.last.avatar.attached?).to be(true)
    end
  end

end
