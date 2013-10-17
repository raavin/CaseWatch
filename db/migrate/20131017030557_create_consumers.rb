class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthdate
      t.references :country
      t.boolean :gender

      t.timestamps
    end
    add_index :consumers, :country_id
  end
end
