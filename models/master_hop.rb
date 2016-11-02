class MasterHop < ActiveRecord::Base
 belongs_to :hop
 belongs_to :master_recipe
end
