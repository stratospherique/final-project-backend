# frozen_string_literal: true

FactoryBot.define do
  factory :favorite, class: Favorite do
    user_id {}
    article_id {}
  end
end