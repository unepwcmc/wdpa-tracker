class CreateDesignationTypes < ActiveRecord::Migration
  def change
    create_table :designation_types do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
