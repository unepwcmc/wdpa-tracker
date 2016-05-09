class CountriesProtectedArea < ActiveRecord::Base
  belongs_to :protected_area
  belongs_to :country
end
