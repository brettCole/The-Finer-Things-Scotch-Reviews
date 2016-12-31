require './config/environment'
require 'rack-flash'

class ConnoisseursController < ApplicationController
	use Rack::Flash

	get '/signup' do
		@title = "Signup"
		if logged_in?
			redirect "/scotches"
		else
			erb :"/connoisseurs/signup"
		end
	end

	post '/signup' do
		@connoisseur = Connoisseur.new(params)
			if @connoisseur.valid? && @connoisseur.save
				session[:id] = @connoisseur.id
				redirect "/scotches"
			else
				flash[:error] = "Already a connoisseur! Please log in!"
				redirect "/signup"
			end
	end

	get '/login' do
		@title = "Login"
		if !!session[:id]
			redirect "/scotches"
		else
			erb :"/connoisseurs/login"
		end
	end

	post '/login' do
		@connoisseur = Connoisseur.find_by(username: params[:username])
		if @connoisseur && @connoisseur.authenticate(params[:password])
			session[:id] = @connoisseur.id
			redirect'/scotches'
		else
			flash[:error] = "Username or Password Do Not Match!"
			redirect '/login'
		end
	end

	get '/logout' do
		session.clear
		redirect '/login'
	end

end
