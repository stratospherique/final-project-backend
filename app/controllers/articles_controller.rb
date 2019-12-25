class ArticlesController < ApplicationController
  
  before_action :find_article, only: [:destroy, :show]

  def index
    @articles = Article.all
    if @articles
      render json: {
        articles: @articles
      }
    else
      render json: {
        status: 500,
        message: ['No data found']
      }
    end
  end


  def find_trending
    @articles = Article.trending
    if @articles
      render json: {
        trending: @articles
      }
    else
      render json: {
        status: 500,
        message: ['No Trending Found']
      }
    end
  end

  def show
    
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render json: {
        article: @article
      }
    else
      render json: {
        status: 500,
        message: @article.errors.full_messages
      }
    end
  end

  def destroy
    @article.destroy
    render json: {
      status: 200,
      message: ["deleted successfully"]
    }
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:description, :price, :buildingType, :propertyType, :city, :footage, :rating, :preview => [])
  end

end