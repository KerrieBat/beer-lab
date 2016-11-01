require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative 'db_config'
require_relative 'models/user'

enable :sessions

get "/" do
  erb :index
end
