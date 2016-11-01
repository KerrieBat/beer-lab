class User < ActiveRecord::Base
  has_secure_password
  has_many :master_recipes
  has_many :user_recipes
end
