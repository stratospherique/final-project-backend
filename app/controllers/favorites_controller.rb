class FavoritesController < ApplicationController
  before_action :is_authenticated?, only: [:create]
  
  def create
    @favorite = Favorite.new(favor_params)
    if @favorite.save
      render json: @favorite.liked_article.id
    else
      render json: {
        message: @favorite.errors.full_messages
      }, status: :internal_server_error
    end
  end

  private

  def favor_params
    params.require(:favorite).permit(:user_id,:article_id)
  end
end