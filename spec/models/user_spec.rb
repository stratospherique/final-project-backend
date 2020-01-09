require 'rails_helper'
require 'faker'

RSpec.describe Article, type: :model do
  context 'adding a user' do
    it 'create a user instance' do
      exp = build :empty_user
      expect(exp.class).to be(User)
    end

    it 'checks if a valid username is entered' do
      user = build :invalid_name_user
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("Username can't be blank",
                                                   'Username is too short (minimum is 4 characters)')
    end

    it 'checks if a valid email is entered' do
      user = build :invalid_email_user
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include('Email is invalid')
    end

    it 'checks if a passwords are matching' do
      user = build :invalid_password_user
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'creates a valid user' do
      user = build :valid_user
      expect(user).to be_valid
      expect(user.admin).to be_falsy
    end

    it 'create an admin user' do
      user = build :admin_user
      expect(user.admin).to be_truthy
    end
  end
end