class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      @user = User.new
      erb :'users/signup'
    else
      redirect to '/builds'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/builds'
    else
       erb :'users/signup'
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
      erb :'users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/builds'
    end
  end


end