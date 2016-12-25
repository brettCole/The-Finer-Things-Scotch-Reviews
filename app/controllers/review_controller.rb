require './config/environment'
require 'rack-flash'

class ReviewsController < ApplicationController
  use Rack::Flash

  post '/review' do #Create new review of scotch
    if logged_in?
      @review = current_user.reviews.new(params)
      #@scotch = current_user.scotches.find_by(params[:id])
      if @review.valid? && @review.save
        #redirect back
        redirect "/reviews/#{@review.scotch.slug}"
      else
        flash[:error] = "Must fill in all fields to complete review!"
        redirect back
      end
    end
  end

  get "/review/:slug/edit" do
    if logged_in?
      @review = current_user.reviews.find_by(params[:id])
      #@review = current_user.reviews.find_by(review_id)
      reviews = params[:reviews_id]
      @reviews = params[:reviews_id]
      @reviewer = Review.find_by(params[:reviews])
      #@review_id = @reviews.id
      if @review.connoisseur_id == session[:id]
        erb :"/reviews/edit_review"
      elsif @review.connoisseur_id != session[:id]
        flash[:message] = "You do not have write privileges to this review!"
        redirect back
      else
        redirect "/reviews"
      end
    end
  end

  patch "/review/:slug" do
    if logged_in?
      #reviews = params[:reviews_id]
      #@reviews = params[:reviews_id]
      @reviewers = Review.find_by_id(params[:reviews_id])
      @review = Review.find_by(params[:@reviews])
      if @reviewers.connoisseur_id == session[:id]
        @reviewers.rating = params[:rating]
        @reviewers.description = params[:description]
        @reviewers.save
        #@review.update_attributes(params)
        redirect "/reviews/#{@reviewers.scotch.slug}"
        #redirect "/reviews/#{@review.scotch.slug}"
      elsif @reviewers.connoisseur_id != session[:id]
        flash.now[:error] = "You do not have write privileges to this review! Head back to reviews!"
        redirect "/reviews"
      else
        redirect "/reviews"
      end
    end
  end

  delete "/review/:id/delete" do
    if logged_in?
      @review = Review.find(params[:id])
      if @review.connoisseur_id == session[:id]
        @review.delete
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
