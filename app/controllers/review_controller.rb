require './config/environment'
require 'rack-flash'

class ReviewsController < ApplicationController
  use Rack::Flash

  post '/review' do
    if logged_in?
      @review = current_user.reviews.new(params)
      if @review.valid? && @review.save
        redirect back
      else
        flash[:error] = "Must fill in all fields to complete review!"
        redirect back
      end
    end
  end

  get "/review/:slug/edit" do
    #@scotch = Scotch.find_by(params[:id])
    @scotch = Scotch.find_by(params[:id])
    @review = current_user.reviews.find_by(params[:id])
    #@scotch = Scotch.find_by(params[:id])
    if logged_in?
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
      #@scotch = Scotch.find_by(params[:id])
      @reviewer = Review.find_by(params[:scotch_id])
      @scotch = Scotch.find_by(params[:id])
      @review = current_user.reviews.find_by(params[:id])
      if @review.connoisseur_id == session[:id]
        @review.rating = params[:rating]
        @review.description = params[:description]
        @review.save
        redirect "/reviews/#{@review.scotch.slug}"
      elsif @reviewer.connoisseur_id != session[:id]
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
