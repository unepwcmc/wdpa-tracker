class WdpaRelease < ActiveRecord::Base
  has_many :protected_areas_wdpa_releases
  has_many :protected_areas, through: :protected_areas_wdpa_releases

  def self.valid_on(datetime)
    WdpaRelease.where("valid_from <= ? AND valid_to > ?", datetime, datetime).first
  end

  def valid_on?(datetime)
    self.valid_from <= datetime && self.valid_to > datetime
  end
end
