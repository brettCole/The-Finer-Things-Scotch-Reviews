require './config/environment'

class ScotchesController < ApplicationController

	get '/reviews' do 
		@title = "Reviews"
		if logged_in?
			@scotch = Scotch.all.distinct
			@connoisseur = Connoisseur.find(session[:id])
			erb :'/scotches/reviews'
		else
			redirect '/login'
		end
	end

	get '/reviews/new' do 
		@title = "Create Review"
		if logged_in?
			@connoisseur = Connoisseur.find(session[:id])
			erb :'/scotches/create_review'
		else
			redirect '/login'
		end	
	end

	post '/reviews' do 
		@scotch = Scotch.create(name: params[:name], rating: params[:rating], price: params[:price], review: params[:review], user_id: session[:id])
		redirect "/reviews"
	end

end