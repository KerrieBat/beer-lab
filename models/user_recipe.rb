class UserRecipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :master_recipe
  has_many :hop_user_recipes
  has_many :fermentable_user_recipes
  has_many :hops, through: :hop_user_recipes
  has_many :fermentables, through: :fermentable_user_recipes

  def add_info params, user_id, master_id
    self.user_id = user_id
    self.master_recipe_id = master_id
    self.volume = params[:volume]

    # TODO:, math and loops here
    self.fermentables << Fermentable.find_by(name: params[:fermentable1])
    self.fermentable_user_recipes[0].update(ppg: params[:ppg1], srm: params[:srm1])
    self.hops << Hop.find_by(name: params[:hop1])
    self.hop_user_recipes[0].update(aa: params[:aa1])
  end
end
