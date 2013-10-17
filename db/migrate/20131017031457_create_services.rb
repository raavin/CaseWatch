class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :service_name
      t.text :description
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
