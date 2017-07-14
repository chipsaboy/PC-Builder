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

end