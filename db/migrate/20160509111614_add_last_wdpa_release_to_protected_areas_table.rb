class AddLastWdpaReleaseToProtectedAreasTable < ActiveRecord::Migration
  def change
    add_belongs_to :protected_areas, :wdpa_release, index: true
  end
end
