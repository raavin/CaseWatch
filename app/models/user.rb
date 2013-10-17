class User < ActiveRecord::Base
  has_many :messages
  has_many :case_notes
  has_many :expenditures
  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role_ids
  
  def role_symbols  
  roles.map do |role|  
    role.name.underscore.to_sym  
  end  
end

end
