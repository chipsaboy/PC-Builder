class PartsController < ApplicationController

  get '/builds/:id/part/new' do
    if logged_in?
      @build = Build.find(params[:id])
      erb :'parts/new'
    else
      flash[:message] = "Please login."
      erb :'users/login'
    end
  end

  post '/builds/:id' do
    if params.values.include?("")
      @build = Build.find(params[:id])
      flash[:message] = "Please fill out all fields."
      erb :'parts/new'
    else
      @build = Build.find(params[:id])
      @part = Part.new(name: params[:name], price: params[:price])
      @part.save
      @build.parts << @part
      redirect to "/builds/#{@build.id}"
    end
  end

  delete '/builds/:id/parts/:part_id/delete' do
    @build = Build.find(params[:id])
    @part = Part.find(params[:part_id])
    if logged_in?
      @build = Build.find(params[:id])
      if @build.user_id == session[:user_id]
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
