class Subscription < ApplicationRecord
  validates_presence_of :title, :price, :status, :frequency
  validates_numericality_of :price
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
  enum status: {"active" => 0, "cancelled" => 1}
end