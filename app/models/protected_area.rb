class ProtectedArea < ActiveRecord::Base
  belongs_to :designation
  belongs_to :wdpa_release

  has_many :countries_protected_areas
  has_many :countries, through: :countries_protected_areas

  has_many :protected_areas_wdpa_releases
  has_many :wdpa_releases, through: :protected_areas_wdpa_releases
end
