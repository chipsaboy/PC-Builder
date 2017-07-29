class BuildsController < ApplicationController

  get '/builds' do
    if logged_in?
      @builds = current_user.builds
      erb :'builds/index'
    else
      flash[:message] = "Please login to access builds."
      redirect to '/login'
    end
  end

  get '/builds/new' do
    if logged_in?
      erb :'builds/new'
    else
      redirect to '/login'
    end
  end

  post '/builds' do
    @build = current_user.builds.build(params)
    if @build.save
      redirect to "/builds/#{@build.id}"
    else
      flash[:message] = @build.errors.full_messages.join(', ')
      redirect to '/builds/new'
    end
  end

  get '/builds/:id' do
    @build = Build.find(params[:id])
    if logged_in? && @build.user_id == current_user.id
      erb :'builds/show'
    else
      flash[:message] = "You do not have access to that build"
      redirect to '/builds'
    end
  end

  get '/builds/:id/edit' do
    @build = Build.find(params[:id])
    if logged_in? && @build.user_id == current_user.id
      erb :'builds/edit'
    else
      redirect to '/builds'
    end
  end

  patch '/builds/:id' do
    @build = Build.find_by_id(params[:id])
    if @build.update({:title => params[:title], :budget => params[:budget]})
      redirect to "/builds/#{@build.id}"
    else
      flash[:message] = @build.errors.full_messages.join(', ')
      redirect to "/builds/#{@build.id}/edit"
    end
  end

  delete '/builds/:id/delete' do
    @build = current_user.builds.find_by_id(params[:id])
    if @build && @build.destroy
      redirect to '/builds'
    else
      redirect to "/builds/#{@build.id}"
    end
  end

end