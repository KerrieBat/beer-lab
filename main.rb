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

helpers do
  def current_user
    User.find_by id: session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def get_stats recipe
    stats = {}
    stats['og'] = recipe.fermentable_master_recipes.sum('target_ppg').to_f / 1000 + 1
    stats['fg'] = ((stats['og'] * 1000 - 1000) * (1 - (recipe.yeast.attenuation.to_f / 100)) + 1000) / 1000
    stats['abv'] = (stats['og'] - stats['fg']) * 131.25
    stats['ibu'] = recipe.hop_master_recipes.sum('ibu')
    stats
  end
end

get '/' do
  if logged_in?
    @recipes = current_user.user_recipes
    erb :user_home
  else
    erb :index
  end
end

get '/signup' do
  redirect to '/' if logged_in?
  erb :signup
end

post '/signup' do
  user = User.create username: params[:username], password: params[:password]
  session[:user_id] = user.id
  redirect to '/'
end

get '/login' do
  redirect to '/' if logged_in?  
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
  session[:user_id] = nil if logged_in?
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
  master_recipe.add_info(params, current_user.id)

  user_recipe = UserRecipe.new
  user_recipe.add_info(params, current_user.id, master_recipe.id)

  redirect to "/#{ current_user.username }/#{ user_recipe.id }"
end

get '/recipes/:id' do
  @recipe = MasterRecipe.find params[:id]
  @fermentables = @recipe.fermentable_master_recipes
  @hops = @recipe.hop_master_recipes
  @stats = get_stats @recipe
  erb :show_master_recipe
end

post '/add/:id' do
  master_recipe = MasterRecipe.find params[:id]
  user_recipe = UserRecipe.create(user_id: current_user.id, master_recipe_id: params[:id])

  fermentables = master_recipe.fermentables
  hops = master_recipe.hops
  fermentables.each do |fermentable|
    user_recipe.fermentables << fermentable
  end
  hops.each do |hop|
    user_recipe.hops << hop
  end
  
  redirect to "/#{ current_user.username }/edit/#{ user_recipe.id }"
end

get '/:username/edit/:id' do
  @recipe = current_user.user_recipes.find params[:id]
  @fermentables = @recipe.fermentable_user_recipes
  @hops = @recipe.hop_user_recipes
  erb :edit_recipe
end

patch '/:username/:id' do
  recipe = current_user.user_recipes.find params[:id]
  recipe.update_info params
  redirect to "/#{ params[:username] }/#{ params[:id] }"
end

delete '/:username/:id' do
  current_user.user_recipes.find(params[:id]).destroy if current_user.username == params[:username]
  redirect to '/'
end

get '/:username/:id' do
  @recipe = current_user.user_recipes.find params[:id]
  @fermentables = @recipe.fermentable_user_recipes
  @hops = @recipe.hop_user_recipes
  erb :show_user_recipe
end
