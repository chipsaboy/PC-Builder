class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/builds'
    end
  end

  post '/signup' do
    if params[:email] == "" || params[:username] == "" || params[:password] == ""
      erb :'users/signup'
    else
      @user = User.new(email: params[:email], username: params[:username], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/builds'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/builds'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/builds'
    else
      flash[:message] = "Incorrect Username or Password, please try again."
      redirect to '/login'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect to '/'
    else
      redirect to '/builds'
    end
  end

end
