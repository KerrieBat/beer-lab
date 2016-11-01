class MasterRecipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :yeast
  belongs_to :style
  has_many :user_recipes
  has_many :hop_master_recipes
  has_many :fermentable_master_recipes
  has_many :hops, through: :hop_master_recipes
  has_many :fermentables, through: :fermentable_master_recipes
end
