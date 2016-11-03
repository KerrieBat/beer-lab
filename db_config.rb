require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'beerlab'
}

ActiveRecord::Base.establish_connection options
