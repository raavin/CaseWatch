class CreateWaitingLists < ActiveRecord::Migration
  def change
    create_table :waiting_lists do |t|
      t.references :consumer
      t.references :service
      t.references :category
      t.datetime :referral_date
      t.datetime :acceptance_date
      t.datetime :completed_date

      t.timestamps
    end
    add_index :waiting_lists, :consumer_id
    add_index :waiting_lists, :service_id
    add_index :waiting_lists, :category_id
  end
end
