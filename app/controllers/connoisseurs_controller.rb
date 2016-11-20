require './config/environment'

class ConnoisseursController < ApplicationController

	get '/signup' do 
		@title = "Signup"
		if !!session[:@connoisseur_id]
			redirect '/reviews'
		else
			erb :'/connoisseurs/signup'
		end
	end

	post '/signup' do 
		if params.any? { |key, value| value.empty? }
			redirect '/signup'
		else
			@connoisseur = Connoisseur.create(params)
			session[:id] = @connoisseur.id
			redirect '/reviews'
		end
	end

	get '/login' do 
		@title = "Login"
		if logged_in?
			redirect '/reviews'
		else
			erb :'/connoisseurs/login'
		end
	end

	post '/login' do 
		@connoisseur = Connoisseur.find_by(username: params[:username])
		if @connoisseur && @connoisseur.authenticate(params[:password])
			session[:id] = @connoisseur.id
			redirect '/reviews'
		else
			redirect '/login'
		end
	end	

	get '/logout' do 
		session.clear
		redirect '/login'
	end

end