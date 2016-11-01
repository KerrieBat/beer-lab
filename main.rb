require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/user_recipe'
require_relative 'models/master_recipe'
require_relative 'models/hop'
require_relative 'models/fermentable'
require_relative 'models/yeast'
require_relative 'models/style'

enable :sessions

get '/' do
  if session[:user_id]
    user = User.find session[:user_id] 
    @username = user.username
    @recipes = user.user_recipes
    erb :user_home
  else
    @username = ''
    erb :index
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
  User.create username: params[:username], password: params[:password]
  redirect to '/'
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by username: params[:username]
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/'
  else
    erb :login
  end
end

delete '/login' do
  session[:user_id] = nil
  redirect to '/'
end
