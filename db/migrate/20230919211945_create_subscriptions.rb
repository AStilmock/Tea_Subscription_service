class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
