class Category < ActiveRecord::Base
  belongs_to :service
  attr_accessible :description, :name
end
