require './config/environment'
require 'rack-flash'

class ScotchesController < ApplicationController
	use Rack::Flash

	get '/scotches' do
		@title = "Reviews"
		if logged_in?
			@scotch = Scotch.all
			erb :"/scotches/reviews"
		else
			redirect '/login'
		end
	end

	get '/scotches/new' do
		@title = "Add Scotch"
		if logged_in?
			@connoisseur = current_connoisseur
			erb :'/scotches/create_review'
		else
			redirect '/login'
		end
	end

	post '/scotches' do
		@scotch = Scotch.new(params)
		if !@scotch.valid?
			flash[:error] = "Must fill in all fields to create scotch!"
			redirect "/scotches/new"
		else
			@scotch.save
			redirect "/scotches/#{@scotch.slug}"
		end
	end

	get "/scotches/:slug" do
		@title = "Scotch Reviews"
		if logged_in?
			@title = "Review"
			@scotch = Scotch.find_by_slug(params[:slug])
			erb :"/scotches/show_review"
		else
			redirect "/login"
		end
	end

	post "/scotches/:slug/reviews" do
		@scotch = Scotch.find_by_slug(params[:slug])
		@review = @scotch.reviews.build(rating: params[:rating], description: params[:description])
		@review.connoisseur = current_connoisseur
		if @review.save
			flash[:notice] = "You just created a review"
		else
			flash[:error] = @review.errors.full_messages
		end
		redirect to "/scotches/#{@scotch.slug}"
	end

	get "/scotches/:slug/reviews/:id/edit" do
		@title = "Edit Review"
		@scotch = Scotch.find_by_slug(params[:slug])
		@review = Review.find_by_id(params[:id])
		erb :'/reviews/edit'
	end

	patch "/scotches/:slug/reviews/:id/edit" do
		@scotch = Scotch.find_by_slug(params[:slug])
		@review = Review.find_by_id(params[:id])
		if @review.update(rating: params[:rating], description: params[:description])
			flash[:notice] = "You updated review"
			redirect "/scotches/#{@scotch.slug}"
		else
			flash[:error] = @review.errors.full_messages
			redirect "/scotches/#{@scotch.slug}/reviews/#{@review.id}/edit"
		end
	end

	delete "/scotches/:id/delete" do
    if logged_in?
      @review = Review.find(params[:id])
      if @review.connoisseur_id == session[:id]
        @review.delete
        flash[:notice] = "You just deleted your review"
        redirect back
      else
        flash[:message] = "You do not have permission to delete this review!"
        redirect back
      end
    else
      redirect '/login'
    end
  end

end
