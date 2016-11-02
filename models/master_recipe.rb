class MasterRecipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :yeast
  belongs_to :style
  has_many :user_recipes
  has_many :hop_master_recipes
  has_many :fermentable_master_recipes
  has_many :hops, through: :hop_master_recipes
  has_many :fermentables, through: :fermentable_master_recipes

  def add_info params, user_id
    self.name = params[:name]
    self.user_id = user_id
    self.mash_temp = params[:mash_temp]
    self.mash_time = params[:mash_time]
    self.ferment_temp = params[:ferment_temp]
    self.style_id = Style.find_or_create_by(name: params[:style]).id
    yeast = Yeast.find_or_create_by(name: params[:yeast])
    self.yeast_id = yeast.id
    yeast.update(attenuation: params[:attenuation])

    # TODO:, math and loops here
    self.fermentables << Fermentable.find_or_create_by(name: params[:fermentable1])
    self.fermentable_master_recipes[0].update(target_ppg: 35)
    self.hops << Hop.find_or_create_by(name: params[:hop1])
    self.hop_master_recipes[0].update(add_time: params[:time1], ibu: 20)
  end
end
