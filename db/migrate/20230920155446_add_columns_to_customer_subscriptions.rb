class AddColumnsToCustomerSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_subscriptions, :status, :integer
    add_column :customer_subscriptions, :frequency, :string
  end
end
