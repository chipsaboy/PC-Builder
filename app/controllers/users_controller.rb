class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/builds'
    else
      @user = User.new
      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/builds'
    else
       flash[:message] = @user.errors.full_messages.join(', ')
       redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/builds'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/builds'
    else
      flash[:message] = "Incorrect Username or Password, please try again."
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end