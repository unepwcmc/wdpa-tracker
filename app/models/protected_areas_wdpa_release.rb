class ProtectedAreasWdpaRelease < ActiveRecord::Base
  belongs_to :protected_area
  belongs_to :wdpa_release
end
