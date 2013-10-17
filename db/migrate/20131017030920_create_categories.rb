class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :service
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :categories, :service_id
  end
end
