class UserRecipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :master_recipe
  has_many :user_hops
  has_many :user_fermentables
  has_many :hops, through: :user_hops
  has_many :fermentables, through: :user_fermentables

  def add_info params, user_id, master_id
    self.user_id = user_id
    self.master_recipe_id = master_id
    self.volume = params[:volume]

    num_of_fermentables = params.keys.select { |key| key.to_s.match(/^fermentable\d+/) }
    num_of_fermentables = num_of_fermentables.length

    num_of_fermentables.times do |i|
      self.fermentables << Fermentable.find_by(name: params["fermentable#{i}"])
      self.user_fermentables[i].update(ppg: params["ppg#{i}"])
    end
    
    num_of_hops = params.keys.select { |key| key.to_s.match(/^hop\d+/) }
    num_of_hops = num_of_hops.length

    num_of_hops.times do |i|
      self.hops << Hop.find_by(name: params["hop#{i}"])
      self.user_hops[i].update(aa: params["aa#{i}"])
    end
  end

  def update_info params
    self.update volume: params[:volume]

    self.user_fermentables.each_with_index do |fermentable, index|
      fermentable.update ppg: params["ppg#{ index }"]
    end

    self.user_hops.each_with_index do |hop, index|
      hop.update aa: params["aa#{ index }"]
    end
  end
end
