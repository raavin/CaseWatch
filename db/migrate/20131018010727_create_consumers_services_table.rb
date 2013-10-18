class CreateConsumersServicesTable < ActiveRecord::Migration

	def self.up
	  create_table :consumers_services, :id => false do |t|
	    t.integer :consumer_id
	    t.integer :service_id
	  end
	end

	def self.down
	  drop_table :consumers_services
	end

end
