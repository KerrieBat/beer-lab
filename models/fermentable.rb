class Fermentable < ActiveRecord::Base
  has_many :user_fermentables
  has_many :master_fermentables
  has_many :user_recipes, through: :user_fermentables
  has_many :master_recipes, through: :master_fermentables
end
