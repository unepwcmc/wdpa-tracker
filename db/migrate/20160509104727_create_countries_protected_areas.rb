class CreateCountriesProtectedAreas < ActiveRecord::Migration
  def change
    create_table :countries_protected_areas do |t|
      t.references :protected_area, foreign_key: true
      t.references :country, foreign_key: true

      t.timestamps null: false
    end

    add_index :countries_protected_areas,
      [:country_id, :protected_area_id],
      unique: true,
      name: "index_cpas_on_country_id_and_protected_area_id"
  end
end
