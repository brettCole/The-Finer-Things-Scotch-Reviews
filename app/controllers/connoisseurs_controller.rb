require './config/environment'

class ConnoisseursController < ApplicationController

	get '/signup' do 
		if session[:@connoisseur_id]
			redirect '/reviews'
		else
			erb :'/connoisseurs/signup'
		end
	end

	get '/login' do 
		erb :'/connoisseurs/login'
	end

	post '/signup' do 
		if params.any? { |key, value| value.empty? }
			redirect '/signup'
		else
			@connoisseur = Connoisseur.create(params)
			session[:user_id] = @connoisseur.id
			redirect '/reviews'
		end
	end

	post '/login' do 
		@connoisseur = Connoisseur.find_by(params[:username])
		if @connoisseur && @connoisseur.authenticate(params[:password])
			session[:user_id] = @connoisseur_id
			redirect '/reviews'
		else
			redirect '/login'
		end
	end	

end