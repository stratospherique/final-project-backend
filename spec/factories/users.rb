# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:empty_user] do
    username {}
    email {}
    password {}
    password_confirmation {}

    factory :valid_user do
      username {'alex'}
      email {'arjen@robben.cl'}
      password {'ass2grass'}
      password_confirmation {'ass2grass'}

      factory :invalid_name_user do
        username {}  
      end

      factory :invalid_email_user do
        email { 'alexsqfddq'}  
      end

      factory :invalid_password_user do
        password_confirmation {'alexsqfddq'}  
      end

      factory :admin_user do
        admin { true }
      end
    end

    factory :agent, class: User, aliases: [:author] do
      username {Faker::Name.unique.name}
      email {Faker::Internet.unique.email}
      password {'ass2grass'}
      password_confirmation {'ass2grass'}
    end
  end
end