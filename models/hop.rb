class Hop < ActiveRecord::Base
  has_many :master_hops
  has_many :user_hops
  has_many :user_recipes, through: :user_hops
  has_many :master_recipes, through: :master_hops
end
