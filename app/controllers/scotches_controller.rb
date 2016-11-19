require './config/environment'

class ScotchesController < ApplicationController

	get '/reviews' do 
		if logged_in?
			@connoisseur.find(session[:user_id])
			erb :'/scotches/reviews'
		else
			redirect '/login'
		end
	end

end