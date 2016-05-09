class CreateProtectedAreas < ActiveRecord::Migration
  def change
    create_table :protected_areas do |t|
      t.text :name
      t.integer :wdpa_id
      t.text :status
      t.references :designation, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :protected_areas, :wdpa_id
    add_index :protected_areas, :status
  end
end
