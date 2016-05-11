class CreateProtectedAreasWdpaReleases < ActiveRecord::Migration
  def change
    create_table :protected_areas_wdpa_releases do |t|
      t.references :protected_area, index: true, foreign_key: true
      t.references :wdpa_release, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
