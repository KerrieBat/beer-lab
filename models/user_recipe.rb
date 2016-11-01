class UserRecipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :master_recipe
  has_many :hops, through: :hops_user_recipes
  has_many :fermentables, through: :fermentables_user_recipes
end
