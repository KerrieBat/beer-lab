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
require_relative 'models/fermentable_master_recipe'
require_relative 'models/fermentable_user_recipe'
require_relative 'models/hop_master_recipe'
require_relative 'models/hop_user_recipe'

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
  user = User.create username: params[:username], password: params[:password]
  session[:user_id] = user.id
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

get '/recipes' do
  @recipes = MasterRecipe.all
  erb :all_recipes
end

get '/recipes/new' do
  erb :new_recipe
end

post '/recipes/new' do
  master_recipe = MasterRecipe.new
  master_recipe.add_info(params, session[:user_id])

  user_recipe = UserRecipe.new
  user_recipe.add_info(params, session[:user_id], master_recipe.id)

  redirect to "/#{ User.find(session[:user_id]).username }/#{ user_recipe.id }"
end

get '/recipes/:id' do
  @recipe = MasterRecipe.find params[:id]
  @fermentables = @recipe.fermentable_master_recipes
  @hops = @recipe.hop_master_recipes
  erb :show_master_recipe
end

get '/:username/:id' do
  user = User.find_by username: params[:username]
  @recipe = user.user_recipes.find params[:id]
  @fermentables = @recipe.fermentable_user_recipes
  @hops = @recipe.hop_user_recipes
  erb :show_user_recipe
end
