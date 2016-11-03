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
    num_of_fermentables = params.keys.select { |key| key.to_s.match(/^fermentable\d+/) }
    num_of_fermentables = num_of_fermentables.length

    num_of_fermentables.times do |i|
      target_ppg = ((params["f_weight#{i}"].to_i * 0.00220462) * params["ppg#{i}"].to_i * 0.75) / (params[:volume].to_i * 0.264172)
      srm += (params["lovi#{i}"].to_f * (params["f_weight#{i}"].to_i * 0.00220462)) / (params[:volume].to_i * 0.264172)
      self.fermentables << Fermentable.find_or_create_by(name: params["fermentable#{i}"])
      self.master_fermentables[i].update(target_ppg: target_ppg)
    end

    self.update(srm: srm.to_i)
    total_gravity = self.master_fermentables.sum('target_ppg')
    total_gravity = total_gravity.to_f / 1000
    f1 = 1.65 * (0.000125 ** (0.785 * total_gravity))

    num_of_hops = params.keys.select { |key| key.to_s.match(/^hop\d+/) }
    num_of_hops = num_of_hops.length

    num_of_hops.times do |i|
      f2 = (1 - (2.718281828459045235 ** (-0.04 * params["time#{i}"].to_i))) / 4.15
      ibu = (f1 * f2 * 1.1) * (((params["aa#{i}"].to_f / 100) * params["h_weight#{i}"].to_i * 1000) / params[:volume].to_i)
      self.hops << Hop.find_or_create_by(name: params["hop#{i}"])
      self.master_hops[i].update(add_time: params["time#{i}"], ibu: ibu)
    end
  end
end
