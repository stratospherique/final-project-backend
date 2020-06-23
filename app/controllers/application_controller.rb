class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include ActionController::Cookies
  include ApiHelper

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  helper_method :login!, :logged_in?, :logout!, :current_user, :authorized_user?, :login!, :is_authenticated?
  

end
