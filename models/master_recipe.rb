class MasterRecipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :yeast
  belongs_to :style
  has_many :user_recipes
  has_many :hops, through: :hops_master_recipes
  has_many :fermentables, through: :fermentables_master_recipes
end
