require 'open-uri';

class UsersController < ApplicationController
  before_action :find_instance, only: [:show]

  def index
    @users = User.all
    if @users
      render json: {
        users: @users
      }
    else
      render json: {
        errors: ['no users found']
      }, status: 500
    end
  end

  def show
    if @user
      display_user(@user)
    else
      render json: {
        errors: ['user not registered']
      }, status: 500
    end
  end

  def create
    if (user_params[:avatar].present?)
      @user = User.new(user_params)
    else
      @user = User.new(user_faceless_params)
    end
    if @user.save
      login!
      display_user(@user)
    else 
      render json: {
        errors: @user.errors.full_messages
      }, status: :internal_server_error
    end
  end

  def get_favorites_ids
    @user = User.find(params[:id])
    if @user
      if @user = current_user
        render json: @user.liked_articles.ids
      else
        render json: {
        error: 'Unauthorized action'
      }, status: :internal_server_error
      end
    else
      render json: {
        error: 'Unregistered User'
      }, status: :internal_server_error
    end
  end

  def get_favorites
    @user = User.find(params[:id])
    if @user
      if @user = current_user
        render json: @user.liked_articles
      else
        render json: {
        error: 'Unauthorized action'
      }, status: :internal_server_error
      end
    else
      render json: {
        error: 'Unregistered User'
      }, status: :internal_server_error
    end
  end

  private

  def find_instance
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :avatar)
  end

  def user_faceless_params
    {
      username: user_params[:username],
      email: user_params[:email],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation],
    }
  end

  
end