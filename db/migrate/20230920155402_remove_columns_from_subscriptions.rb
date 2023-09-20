class RemoveColumnsFromSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :status, :integer
    remove_column :subscriptions, :frequency, :string
  end
end
