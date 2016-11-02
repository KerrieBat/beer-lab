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

    # TODO: loops for multiple ingredients
    target_ppg = ((params[:f_weight1].to_i * 0.00220462) * params[:ppg1].to_i * 0.75) / (params[:volume].to_i * 0.264172)
    self.fermentables << Fermentable.find_or_create_by(name: params[:fermentable1])
    self.fermentable_master_recipes[0].update(target_ppg: target_ppg)

    total_gravity = 0
    self.fermentable_master_recipes.each { |o| total_gravity += o.target_ppg }
    total_gravity = total_gravity.to_f / 1000
    f1 = 1.65 * (0.000125 ** (0.785 * total_gravity))

    f2 = (1 - (2.718281828459045235 ** (-0.04 * params[:time1].to_i))) / 4.15
    ibu = (f1 * f2 * 1.1) * (((params[:aa1].to_f / 100) * params[:h_weight1].to_i * 1000) / params[:volume].to_i)
    self.hops << Hop.find_or_create_by(name: params[:hop1])
    self.hop_master_recipes[0].update(add_time: params[:time1], ibu: ibu)
  end
end
