class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id, index: true
      t.integer :status
      t.decimal :additional_charge, :total_price
      t.datetime :transaction_date
      t.string :note

      t.timestamps
    end
  end
end
