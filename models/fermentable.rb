class Fermentable < ActiveRecord::Base
  has_many :fermentable_user_recipes
  has_many :fermentable_master_recipes
  has_many :user_recipes, through: :fermentable_user_recipes
  has_many :master_recipes, through: :fermentable_master_recipes
end
