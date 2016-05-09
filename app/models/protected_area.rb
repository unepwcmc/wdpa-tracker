class ProtectedArea < ActiveRecord::Base
  has_paper_trail

  belongs_to :designation
  belongs_to :wdpa_release

  has_many :countries_protected_areas
  has_many :countries, through: :countries_protected_areas
end
