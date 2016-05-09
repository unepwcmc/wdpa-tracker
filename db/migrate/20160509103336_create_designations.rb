class CreateDesignations < ActiveRecord::Migration
  def change
    create_table :designations do |t|
      t.text :name
      t.references :designation_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
