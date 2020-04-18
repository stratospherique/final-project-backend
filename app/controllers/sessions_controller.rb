class SessionsController < ApplicationController
  
  def create
    @user = User.find_by(username: session_params[:username])
    if @user && @user.authenticate(session_params[:password])
      login!
      render json: {
        logged_in: true,
        user: @user,
        link: url_for(@user.avatar)
      }
    else
      render json: {
        status: 500,
        errors: ['no such user','Please verify your credentials']
      }
    end
  end

  def is_logged_in?
    if logged_in? && current_user
      render json: {
        logged_in: true,
        user: current_user,
        link: url_for(current_user.avatar)
      }
    else
      render json: {
        logged_in: false,
        message: 'no such user',
        status: :internal_server_error
      }
    end
  end

  def destroy
    logout!
    render json: {
      logged_out: true,
      status: 200
    }
  end

  private

  def session_params
    params.require(:user).permit(:username,:password)
  end
end