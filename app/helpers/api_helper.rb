module ApiHelper
    
  def logged_in?
    !!session[:user_id]
  end
    

  def logout!
     session.clear
     @current_user = nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorized_user?
     @user == current_user
  end

  def login!
    session[:user_id] = @user.id
  end

  def is_authenticated?
    unless self.logged_in? #!!session[:user_id] && self.current_user
      render json: {
        message: ["not authorized action"]
        }, status: 404
    end
  end

  def display_user(user)
    if user.avatar.attached?
      render json: {
        user: user,
        link: url_for(user.avatar)
      }
    else
      render json: {
        user: user,
        link: 'http://res.cloudinary.com/ddx20vuxl/image/upload/v1586894678/user_utwpej.png'
      }
    end
  end

end
