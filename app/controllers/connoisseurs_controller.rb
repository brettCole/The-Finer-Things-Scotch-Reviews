require './config/environment'

class ConnoisseursController < ApplicationController

	get '/signup' do 
		erb :'/connoisseurs/signup'
		"hello world"
	end

	get '/login' do 
		erb :'/connoisseurs/login'
		"hello world"
	end

end