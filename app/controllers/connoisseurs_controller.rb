require './config/environment'

class ConnoisseursController < ApplicationController

	get '/signup' do 
		@title = "Signup"	#Tab Title for Page
		if logged_in?	#or if !!session[:id]- checks to see if there is a session[:id]
			redirect "/reviews"
		else
			erb :"/connoisseurs/signup"
		end
	end

	post '/signup' do 
		if params.any? { |key, value| value.empty? }	
			redirect "/signup"
		else
			@connoisseur = Connoisseur.create(params)	#params= id, username, email, and password
			session[:id] = @connoisseur.id	#need to use session[:id] not session[:user_id] so that sign-in is automatic
			redirect "/reviews"
		end
	end

	get '/login' do 
		@title = "Login"	#Tab Title for Page
		if !!session[:id]	#or if logged_in?- checks to see if there is a session[:id]
			redirect "/reviews"
		else
			erb :"connoisseurs/login"
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

	get '/connoisseurs/:slug' do 
		"hello world"
		@connoisseur = current_user
		erb :"/scotches/show_review"
	end


end