require './config/environment'
require 'rack-flash'

class ConnoisseursController < ApplicationController
	use Rack::Flash

	get '/signup' do
		@title = "Signup"	#Tab Title for Page
		if logged_in?	#or if !!session[:id]- checks to see if there is a session[:id]
			redirect "/reviews"
		else
			erb :"/connoisseurs/signup"
		end
	end

	post '/signup' do
		@connoisseur = Connoisseur.new(:username => params[:username], :email => params[:email], :password => params[:password])
			if @connoisseur.valid? && @connoisseur.save	#checks validations in model
				session[:id] = @connoisseur.id
				redirect "/reviews"
			else
				flash[:error] = "Already a connoisseur! Please log in!"
				redirect "/signup"
			end
	end

	get '/login' do
		@title = "Login"	#Tab Title for Page
		if !!session[:id]	#or if logged_in?- checks to see if there is a session[:id]
			redirect "/reviews"
		else
			erb :"/connoisseurs/login"
		end
	end

	post '/login' do
		@connoisseur = Connoisseur.find_by(username: params[:username])	#assigns username as a @connoisseur variable value
		if @connoisseur && @connoisseur.authenticate(params[:password])	#takes that username value and authenticates the corresponding password value
			#session[:id] = @connoisseur.user_id													#to make sure it matches to username
			session[:id] = @connoisseur.id
			redirect'/reviews'
		else
			flash[:error] = "Username or Password Do Not Match!"
			redirect '/login'
		end
	end

	get '/logout' do
		session.clear	#clears session[:id]
		redirect '/login'
	end

end
