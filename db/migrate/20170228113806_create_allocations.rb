class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.text :comment

      t.references :protected_area, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :allocations, :protected_area_id, unique: true
  end
end
