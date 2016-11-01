require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative 'db_config'

get "/" do
  erb :index
end
