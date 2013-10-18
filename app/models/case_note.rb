class CaseNote < ActiveRecord::Base
  belongs_to :user
  belongs_to :consumer
  belongs_to :service
  
  attr_accessible :body, :subject
end
