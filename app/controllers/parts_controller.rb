class PartsController < ApplicationController

  get '/builds/:id/parts/new' do
    if logged_in?
      @build = current_user.builds.find_by_id(params[:id])
      erb :'parts/new'
    else
      redirect to '/login'
    end
  end

  post '/builds/:id' do
    @build = current_user.builds.find_by_id(params[:id])
    @part = @build.parts.build(name: params[:name], price: params[:price])
    if @part.save
      redirect to "/builds/#{@build.id}"
    else
      flash[:message] = @part.errors.full_messages.join(', ')
      redirect to "/builds/#{@build.id}/parts/new"
    end
  end

  delete '/builds/:id/parts/:part_id/delete' do
    @build = current_user.builds.find_by_id(params[:id])
    @part = Part.find(params[:part_id])
    if @part && @part.destroy
      redirect to "/builds/#{@build.id}"
    else
      redirect to "/builds/#{@build.id}/#{@part.id}/edit"
    end
  end

end
