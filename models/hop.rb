class Hop < ActiveRecord::Base
  has_many :hop_master_recipes
  has_many :hop_user_recipes
  has_many :user_recipes, through: :hop_user_recipes
  has_many :master_recipes, through: :hop_master_recipes
end
