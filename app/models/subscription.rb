class Subscription < ApplicationRecord
  validates_presence_of :title, :price
  validates_numericality_of :price
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
end