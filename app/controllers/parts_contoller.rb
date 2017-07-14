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

end
