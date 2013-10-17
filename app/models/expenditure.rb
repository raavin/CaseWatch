class Expenditure < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  belongs_to :service

  validates_numericality_of :amount
  attr_accessible :amount, :description
end
