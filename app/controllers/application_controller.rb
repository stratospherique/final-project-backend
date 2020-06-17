class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include ActionController::Cookies
  include ApiHelper

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!
  
  protected 

  def is_authenticated?
    if authorized_user?
      render json: {
        message: ["not authorized action"]
        }, status: 404
    end
  end

end
