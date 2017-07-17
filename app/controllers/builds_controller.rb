class BuildsController < ApplicationController

  get '/builds' do
    if logged_in?
      @builds = current_user.builds
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
    if params.values.include?("")
      flash[:message] = "Please fill out all fields."
      erb :'builds/new'
    else
      @build = Build.create(title: params[:title], budget: params[:budget], user_id: current_user.id)
      redirect to "/builds/#{@build.id}"
    end
  end

  get '/builds/:id' do
    if logged_in?
      @build = Build.find(params[:id])
      erb :'builds/show'
    else
      flash[:message] = "Please login to access builds."
      erb :'users/login'
    end
  end

  get '/builds/:id/edit' do
    if logged_in?
      @build = Build.find(params[:id])
      if @build.user_id == current_user.id
        erb :'builds/edit'
      else
        redirect to '/builds'
      end
    else
      flash[:message] = "Please login to access builds."
      erb :'users/login'
    end
  end

  patch '/builds/:id' do
    if params.values.include?("")
      @build = Build.find(params[:id])
      flash[:message] = "Please fill out all fields."
      erb :'builds/edit'
      redirect to "/builds/#{params[:id]}/edit"
    else
      @build = Build.find(params[:id])
      @build.title = params[:title]
      @build.budget = params[:budget]
      @build.save
      redirect to "/builds/#{@build.id}"
    end
  end

  delete '/builds/:id/delete' do
    if logged_in?
      @build = Build.find_by_id(params[:id])
      if @build.user_id == current_user.id
        @build.delete
        redirect to '/builds'
      else
        redirect to '/builds'
      end
    else
      redirect to '/login'
    end
  end

end