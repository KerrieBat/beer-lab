class FermentableUserRecipe < ActiveRecord::Base
 belongs_to :fermentable
 belongs_to :user_recipe
end
