require './config/environment'

class ScotchesController < ApplicationController

	get '/reviews' do 
		@title = "Reviews"	#Tab Tile for Page
		if logged_in?
			@scotch = Scotch.all.distinct
			@connoisseur = Connoisseur.find(session[:id])
			erb :"scotches/reviews"
		else
			redirect '/login'
		end
	end

	get '/reviews/new' do 
		@title = "Create Review"	#Tab Title for Page
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

	get "/reviews/:id" do 
			@scotch = Scotch.find_by_id(params[:id])
		if logged_in?
			erb :"/scotches/show_review"
		else
			redirect "/login"
		end
	end

	get '/reviews/:id/edit' do 
	end

end