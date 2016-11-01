require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/user_recipe'
require_relative 'models/master_recipe'

enable :sessions

get "/" do
  erb :index
end
