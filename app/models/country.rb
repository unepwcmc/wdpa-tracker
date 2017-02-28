class Country < ActiveRecord::Base
  has_many :countries_protected_areas
  has_many :protected_areas, through: :countries_protected_areas

  has_many :allocations
end
