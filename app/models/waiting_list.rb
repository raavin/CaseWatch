class WaitingList < ActiveRecord::Base
  belongs_to :consumer
  belongs_to :service
  belongs_to :category
  attr_accessible :acceptance_date, :completed_date, :referral_date
end
