class ArticlesController < ApplicationController
  
  before_action :find_article, only: [:destroy, :show]
  before_action :is_authenticated?, only: [:create, :destroy]
  

  def index
    @articles = Article.all
    if !@articles.empty?
      render json: {
        articles: @articles
      }
    else
      render json: {
        message: ['No data found'],
      }, status: :internal_server_error
    end
  end


  def find_trending
    @articles = Article.trending
    if !@articles.empty?
      render json: {
        trending: @articles
      }
    else
      render json: {
        message: ['No Trending Found']
      }, status: :internal_server_error
    end
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      render json: {
        article: @article
      }
    else
      render json: {
        message: @article.errors.full_messages,
      }, status: :internal_server_error
    end
  end

  def destroy
    begin
      raise 'Unauthorized Action' if (@article.user_id != current_user.id && !current_user.admin)
      @article.destroy
      render json: {
        status: 200,
        message: ["deleted successfully"]
      }
    rescue => exception
      render json: {
        message: [exception],
      }, status: :internal_server_error
    end
  end

  private

  def find_article
    begin
      @article = Article.find(params[:id])
    rescue => exception
      render json: {
        message: [exception],
      }, status: :internal_server_error    
    end
    
  end



  def article_params
    params.require(:article).permit(:description, :price, :buildingType, :propertyType, :city, :footage, :rating, :preview => [])
  end

end