class PartsController < ApplicationController

  get '/builds/:id/parts/new' do
    if logged_in?
      @build = Build.find(params[:id])
      erb :'parts/new'
    else
      flash[:message] = "Please login."
      redirect to '/login'
    end
  end

  post '/builds/:id' do
    if logged_in?
      @build = Build.find(params[:id])
      @part = @build.parts.build(name: params[:name], price: params[:price])
      if @part.save
        redirect to "/builds/#{@build.id}"
      else
        flash[:message] = @parts.errors.full_messages.join(', ')
        erb :'parts/new'
      end
    else
      redirect to '/login'
    end
  end

  delete '/builds/:id/parts/:part_id/delete' do
    if logged_in?
      @build = Build.find_by_id(params[:id])
      if @build.user_id == current_user.id
        @part = Part.find(params[:part_id])
        @part.delete
        redirect to "/builds/#{@build.id}"
      else
        redirect to "/builds/#{@build.id}"
      end
    else
      flash[:message] = "Please login."
      erb :'users/login'
    end
  end

end
