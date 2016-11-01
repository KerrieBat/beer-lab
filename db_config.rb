require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'brewrepo'
}

ActiveRecord::Base.establish_connection options
