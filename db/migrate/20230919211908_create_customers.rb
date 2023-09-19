class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :title
      t.integer :price
      t.string :status
      t.integer :frequency

      t.timestamps
    end
  end
end
