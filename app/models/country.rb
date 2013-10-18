class Country < ActiveRecord::Base
	has_many :consumers
  attr_accessible :iso, :iso3, :name, :numcode, :printable_name
end
