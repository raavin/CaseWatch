class CreateCaseNotes < ActiveRecord::Migration
  def change
    create_table :case_notes do |t|
      t.references :user
      t.references :consumer
      t.references :service
      t.string :subject
      t.text :body

      t.timestamps
    end
    add_index :case_notes, :user_id
    add_index :case_notes, :consumer_id
    add_index :case_notes, :service_id
  end
end
