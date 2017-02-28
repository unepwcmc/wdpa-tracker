class Allocation < ActiveRecord::Base
  belongs_to :country
  belongs_to :protected_area
  belongs_to :user
end
