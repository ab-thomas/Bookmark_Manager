get '/sessions/new' do
  erb :"sessions/new"
end

post '/sessions' do 
  email, password = params[:email], params[:password]
  user = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ["The email or pasword are incorrect"]
      erb :"sessions/new"
    end
  end


    delete '/' do
    session[:user_id] = nil
    flash[:notice] = "Goodbye!"
    redirect to('/')
  end
