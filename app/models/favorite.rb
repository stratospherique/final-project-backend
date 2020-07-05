class Favorite < ApplicationRecord
  belongs_to :liker, class_name: 'User', foreign_key: :user_id
  belongs_to :liked_article, class_name: 'Article', foreign_key: :article_id
end
