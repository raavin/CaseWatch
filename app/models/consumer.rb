class Consumer < ActiveRecord::Base
  belongs_to :country
  has_many :case_notes
  has_many :expenditures
  has_many :waiting_lists
  has_and_belongs_to_many :services
  
  def service_symbols  
  services.map do |service|  
    service.service_name.underscore.to_sym  
  end  
 end
  attr_accessible :birthdate, :firstname, :gender, :lastname
end
