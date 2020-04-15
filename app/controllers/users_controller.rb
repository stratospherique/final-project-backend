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
        status: 500,
        errors: ['no users found']
      }
    end
  end

  def show
    if @user
      render json: {
        user: @user,
        avatar_link: url_for(@user.avatar)
      }
    else
      render json: {
        status: 500,
        errors: ['user not registered']
      }, status: :internal_server_error
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if (params[:user][:avatar])
        @user.avatar.attach(params[:user][:avatar])
      else
        file = open('https://res.cloudinary.com/ddx20vuxl/image/upload/v1586894678/user_utwpej.png')
        @user.avatar.attach(io: file, filename: 'user.png', content_type: 'image/png')  
      end
      login!
      render json: {
        status: :created,
        user: @user,
        link: url_for(@user.avatar)
      }
    else 
      render json: {
        status: :internal_server_error,
        errors: @user.errors.full_messages
      }, status: :internal_server_error
    end
  end

  def get_favorites_ids
    @user = User.find(params[:id])
    if @user
      if @user = current_user
        render json: @user.articles.ids
      else
        render json: {
        status: :internal_server_error,
        error: 'Unauthorized action'
      }  
      end
    else
      render json: {
        status: :internal_server_error,
        error: 'Unregistered User'
      }
    end
  end

  def get_favorites
    @user = User.find(params[:id])
    if @user
      if @user = current_user
        render json: @user.articles
      else
        render json: {
        status: :internal_server_error,
        error: 'Unauthorized action'
      }  
      end
    else
      render json: {
        status: :internal_server_error,
        error: 'Unregistered User'
      }
    end
  end

  private

  def find_instance
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end
  
end