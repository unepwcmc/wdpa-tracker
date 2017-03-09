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

  def present_intervals
    intervals = []
    current_interval = []
    found = false

    WdpaRelease.order(:created_at).each do |release|
      if self.wdpa_releases.include?(release) && !found
        current_interval << release.created_at
        found = true
      end

      if !self.wdpa_releases.include?(release) && found
        current_interval << release.created_at

        intervals << current_interval.clone
        current_interval = []
        found = false
      end
    end

    # handle last release, to present day
    if current_interval.length == 1
      intervals << current_interval
    end

    return intervals
  end
end
