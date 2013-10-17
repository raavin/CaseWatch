class CreateExpenditures < ActiveRecord::Migration
  def change
    create_table :expenditures do |t|
      t.references :consumer
      t.references :user
      t.references :service
      t.string :description
      t.float :amount

      t.timestamps
    end
    add_index :expenditures, :consumer_id
    add_index :expenditures, :user_id
    add_index :expenditures, :service_id
  end
end
