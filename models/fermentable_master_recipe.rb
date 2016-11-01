class FermentableMasterRecipe < ActiveRecord::Base
 belongs_to :fermentable
 belongs_to :master_recipe
end
