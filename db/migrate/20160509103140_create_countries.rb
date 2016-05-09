class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :iso3, limit: 3
      t.text :name

      t.timestamps null: false
    end
    add_index :countries, :iso3, unique: true
  end
end
