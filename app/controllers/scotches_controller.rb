require './config/environment'
require 'rack-flash'

class ScotchesController < ApplicationController
	use Rack::Flash

	get '/reviews' do
		@title = "Reviews"
		if logged_in?
			@scotch = Scotch.all
#			@connoisseur = Connoisseur.find(session[:id])
			erb :"/scotches/reviews"
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
		@scotch = Scotch.new(params)
		if !@scotch.valid?
			flash[:error] = "Must fill in all fields to create scotch!"
			redirect "/reviews/new"
		else
			@scotch.save
			redirect "/reviews"
		end
	end

	get "/reviews/:slug" do
		@title = "Review"
		@scotch = Scotch.find_by_slug(params[:slug])
		@connoisseur = Connoisseur.find(session[:id])
		@review = @scotch.reviews.all
		if logged_in?
			erb :"/scotches/show_review"
		else
			redirect "/login"
		end
	end

end
