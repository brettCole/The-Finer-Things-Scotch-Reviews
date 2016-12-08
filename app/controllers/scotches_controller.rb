require './config/environment'
require 'rack-flash'

class ScotchesController < ApplicationController
	use Rack::Flash

	get '/reviews' do
		@title = "Reviews"	#Tab Tile for Page
		if logged_in?
			@scotch = Scotch.all
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

	#post '/reviews' do
	#	@scotch = Scotch.create(name: params[:name],
	#		rating: params[:rating], price: params[:price],
	#		review: params[:review], connoisseurs_id: session[:id])
	#	redirect "/reviews"
	#end
	post '/reviews' do
		@scotch = Scotch.new(name: params[:name], rating: params[:rating], price: params[:price], review: params[:review], connoisseurs_id: session[:id])
		if !@scotch.valid?
			flash[:error] = "Must fill in all fields to complete review!"
			redirect '/reviews/new'
		else
			@scotch.save
			redirect "/reviews"
		end
	end

	get "/reviews/:slug" do
		@title = "Review"	#Tab Title for Page
		@scotch = Scotch.find_by_slug(params[:slug])
		@connoisseur = Connoisseur.find(session[:id])
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
			if @scotch.connoisseurs_id == session[:id]
				erb :"/scotches/edit_review"
			elsif @scotch.connoisseurs_id != session[:id]
				flash.now[:error] = "You do not have write privileges to this review! Head back to reviews"
				erb :"/scotches/edit_review"
			else
				redirect "/reviews"
			end
		else
			"/login"
		end
	end

	patch "/reviews/:slug" do
		if logged_in?
			@scotch = Scotch.find_by_slug(params[:slug])
			if @scotch.connoisseurs_id != session[:id]

				#needs to use flash.now so that the error message doesn't show up instantly
				flash.now[:error] = "You do not have write privileges to this review! Head back to reviews"
				erb :"/scotches/edit_review"

			elsif @scotch.connoisseurs_id == session[:id] && params[:name] == "" || params[:rating] == "" || params[:price] == "" || params[:review] == ""


				#needs to use flash.now so that the error message doesn't show up instantly
				flash.now[:error] = "Must fill in all fields to complete review!"
				erb :"/scotches/edit_review"

			elsif @scotch.connoisseurs_id == session[:id]
				@scotch.name = params[:name]
				@scotch.rating = params[:rating]
				@scotch.price = params[:price]
				@scotch.review = params[:review]
				@scotch.save
				redirect '/reviews'
			else
				redirect '/reviews'
			end
		end
	end

	delete "/reviews/:slug/delete" do
		if logged_in?
			@scotch = Scotch.find_by_slug(params[:slug])
			if @scotch.connoisseurs_id == session[:id]
				@scotch.delete
				redirect '/reviews'
			else
				redirect '/reviews'
			end
		else
			redirect '/login'
		end
	end

end
