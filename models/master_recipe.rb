class MasterRecipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :yeast
  belongs_to :style
  has_many :user_recipes
  has_many :master_hops
  has_many :master_fermentables
  has_many :hops, through: :master_hops
  has_many :fermentables, through: :master_fermentables

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

    srm = 0

    # TODO: loops for multiple ingredients
    target_ppg = ((params[:f_weight1].to_i * 0.00220462) * params[:ppg1].to_i * 0.75) / (params[:volume].to_i * 0.264172)
    srm += (params[:lovi1].to_f * (params[:f_weight1].to_i * 0.00220462)) / (params[:volume].to_i * 0.264172)
    self.fermentables << Fermentable.find_or_create_by(name: params[:fermentable1])
    self.master_fermentables[0].update(target_ppg: target_ppg)

    self.update(srm: srm.to_i)
    total_gravity = self.master_fermentables.sum('target_ppg')
    total_gravity = total_gravity.to_f / 1000
    f1 = 1.65 * (0.000125 ** (0.785 * total_gravity))

    f2 = (1 - (2.718281828459045235 ** (-0.04 * params[:time1].to_i))) / 4.15
    ibu = (f1 * f2 * 1.1) * (((params[:aa1].to_f / 100) * params[:h_weight1].to_i * 1000) / params[:volume].to_i)
    self.hops << Hop.find_or_create_by(name: params[:hop1])
    self.master_hops[0].update(add_time: params[:time1], ibu: ibu)
  end
end
