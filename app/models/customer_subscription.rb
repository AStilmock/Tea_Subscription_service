class CustomerSubscription < ApplicationRecord
  validates_presence_of :status, :frequency
  belongs_to :customer
  belongs_to :subscription
  enum status: {"active" => 0, "cancelled" => 1}
end