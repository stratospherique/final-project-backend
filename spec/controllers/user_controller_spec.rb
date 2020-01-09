# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'return list users' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
