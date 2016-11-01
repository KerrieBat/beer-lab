class UserRecipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :master_recipe
  has_many :hop_user_recipes
  has_many :fermentable_user_recipes
  has_many :hops, through: :hop_user_recipes
  has_many :fermentables, through: :fermentable_user_recipes
end
