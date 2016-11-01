class Hop < ActiveRecord::Base
  has_many :user_recipes, through: :hops_user_recipes
  has_many :master_recipes, through: :hops_master_recipes
end
