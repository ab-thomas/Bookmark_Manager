# A helper will give us access to the current user if logged in 
helpers do

  def current_user
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end

end