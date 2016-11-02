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

    # TODO: math and loops here
    self.fermentables << Fermentable.find_by(name: params[:fermentable1])
    self.user_fermentables[0].update(ppg: params[:ppg1])
    self.hops << Hop.find_by(name: params[:hop1])
    self.user_hops[0].update(aa: params[:aa1])
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
