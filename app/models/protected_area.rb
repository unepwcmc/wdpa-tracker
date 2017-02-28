class ProtectedArea < ActiveRecord::Base
  belongs_to :designation
  belongs_to :wdpa_release

  has_many :countries_protected_areas, dependent: :destroy
  has_many :countries, through: :countries_protected_areas

  has_many :protected_areas_wdpa_releases
  has_many :wdpa_releases, through: :protected_areas_wdpa_releases

  has_one :allocation

  def last_wdpa_version
    self.wdpa_releases.order(created_at: :desc).first.pretty_name
  end

  def only_allocated?
    status == "allocated" && wdpa_releases.empty?
  end
end
