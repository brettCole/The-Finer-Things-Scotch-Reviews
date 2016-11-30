require './config/environment'
require 'pry'

class ScotchesController < ApplicationController

	get '/reviews' do 
		@title = "Reviews"	#Tab Tile for Page
		if logged_in?
			@scotch = Scotch.all.distinct
			@connoisseur = Connoisseur.find(session[:id])
			erb :"/scotches/reviews"
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
		@scotch = Scotch.create(name: params[:name], rating: params[:rating], price: params[:price], review: params[:review], connoisseurs_id: session[:id])
		redirect "/reviews"
	end


	get "/reviews/:slug" do 
		@title = "Review"	#Tab Title for Page
		@scotch = Scotch.find_by_slug(params[:slug])
		#binding.pry
		if logged_in?
			erb :"/scotches/show_review"
		else
			redirect "/login"
		end
	end

	get "/reviews/:slug/edit" do
		@title = "Edit Review"	#Tab Title for Page
		@scotch = Scotch.find_by_slug(params[:slug])
		if logged_in?
			#binding.pry
			#@scotch = Scotch.find_by_id(params[:id])
			if @scotch.connoisseurs_id == session[:id]
				erb :"/scotches/edit_review"
			else
				redirect "/reviews"
			end
		else
			"/login"
		end
	end

end




