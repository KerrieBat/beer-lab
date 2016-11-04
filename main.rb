require 'sinatra'
# require 'sinatra/reloader'
require 'pry'

require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/user_recipe'
require_relative 'models/master_recipe'
require_relative 'models/hop'
require_relative 'models/fermentable'
require_relative 'models/yeast'
require_relative 'models/style'
require_relative 'models/master_fermentable'
require_relative 'models/user_fermentable'
require_relative 'models/master_hop'
require_relative 'models/user_hop'

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
    stats['og'] = recipe.master_fermentables.sum('target_ppg').to_f / 1000 + 1
    stats['fg'] = ((stats['og'] * 1000 - 1000) * (1 - (recipe.yeast.attenuation.to_f / 100)) + 1000) / 1000
    stats['abv'] = (stats['og'] - stats['fg']) * 131.25
    stats['ibu'] = recipe.master_hops.sum('ibu')
    stats
  end

  def get_srm_color srm
    return '#F8F753' if srm <= 2
    return '#F6F513' if srm <= 3
    return '#ECE61A' if srm <= 4
    return '#D5BC26' if srm <= 6
    return '#BF923B' if srm <= 8
    return '#BF813A' if srm <= 10
    return '#BC6733' if srm <= 13
    return '#8D4C32' if srm <= 17
    return '#5D341A' if srm <= 20
    return '#261716' if srm <= 24
    return '#0F0B0A' if srm <= 29
    return '#080707' if srm <= 35
    '#030403'
  end

  def get_fermentable_weight fermentable, recipe, index
    target = recipe.master_recipe.master_fermentables[index].target_ppg
    diff = target / fermentable.ppg.to_f
    vol_gals = recipe.volume * 0.264172
    weight = vol_gals * diff * 453.592
  end

  def get_hop_weight hop, recipe, index
    target = recipe.master_recipe.master_hops[index].ibu

    total_gravity = recipe.master_recipe.master_fermentables.sum('target_ppg')
    total_gravity = total_gravity.to_f / 1000
    f1 = 1.65 * (0.000125 ** (0.785 * total_gravity))

    time = recipe.master_recipe.master_hops[index].add_time
    ibu = recipe.master_recipe.master_hops[index].ibu
    f2 = (1 - (2.718281828459045235 ** (-0.04 * time))) / 4.15
    weight = (ibu * recipe.volume) / (10 * hop.aa * (f1 * f2 * 1.1))
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
  @auto_style = ''
  Style.all.each {|v| @auto_style += "#{v.name},"}
  @auto_yeast = ''
  Yeast.all.each {|v| @auto_yeast += "#{v.name},"}
  @auto_fermentable = ''
  Fermentable.all.each {|v| @auto_fermentable += "#{v.name},"}
  @auto_hops = ''
  Hop.all.each {|v| @auto_hops += "#{v.name},"}
  
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
  @fermentables = @recipe.master_fermentables
  @hops = @recipe.master_hops
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
  @fermentables = @recipe.user_fermentables
  @hops = @recipe.user_hops
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
  @fermentables = @recipe.user_fermentables
  @hops = @recipe.user_hops
  @stats = get_stats @recipe.master_recipe
  erb :show_user_recipe
end
