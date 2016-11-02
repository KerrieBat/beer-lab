class UserHop < ActiveRecord::Base
 belongs_to :hop
 belongs_to :user_recipe
end
