class Service < ActiveRecord::Base
	has_many :expenditures
  	attr_accessible :description, :max_age, :min_age, :service_name
end
