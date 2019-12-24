class FavoritesController < ApplicationController
  
  def create
    @favorite = Favorite.new(favor_params)
    if @favorite.save
      render json: @favorite.article.id
    else
      render json: {
        status: 500,
        already: true
      }
    end
  end

  private

  def favor_params
    params.require(:favorite).permit(:user_id,:article_id)
  end
end