class CreateWdpaReleases < ActiveRecord::Migration
  def change
    create_table :wdpa_releases do |t|
      t.text :name
      t.datetime :valid_from
      t.datetime :valid_to

      t.timestamps null: false
    end
  end
end
