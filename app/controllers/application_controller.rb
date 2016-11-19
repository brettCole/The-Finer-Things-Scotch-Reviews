require './config/environment'

class ApplicationController < Sinatra::Base
 
	configure do 
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "TheFinerThings"
	end

	get '/' do 
		@title = "The Finer Things In Life"
		erb :'/index'
	end

end