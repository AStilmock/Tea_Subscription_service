class Subscription < ApplicationRecord
  validates_presence_of :frequency, :status
  belongs_to :customer
  belongs_to :tea
  enum status: [:active, :cancelled]
end