class BuildsController < ApplicationController

  get '/builds' do
    if logged_in?
      @builds = Build.all
      erb :'builds/index'
    else
      flash[:message] = "Please login to access builds."
      erb :'users/login'
    end
  end

  get '/builds/new' do
    if logged_in?
      erb :'builds/new'
    else
      flash[:message] = "Please login to access builds."
      erb :'users/login'
    end
  end

  post '/builds' do
    if params[:title] == "" || params[:budget] == ""
      flash[:message] = "Please fill out all fields."
    else
      user = User.find(session[:user_id])
      @build = Build.create(title: params[:title], budget: params[:budget], user_id: params[:user_id])
      redirect to "/builds/#{@build.id}"
    end
  end

  get '/builds/:id/' do
    if logged_in?
      @build = Build.find(params[:id])
      erb :'builds/show'
    else
      flash[:message] = "Please login to access builds."
      erb :'users/login'
    end
  end

end
