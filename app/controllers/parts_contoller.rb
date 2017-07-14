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

end
