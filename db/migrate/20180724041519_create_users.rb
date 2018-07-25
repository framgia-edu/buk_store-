class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, :gender, :address,
        :phone_number, :card_number, :email
      t.datetime :birthday
      t.integer :user_type
      t.boolean :block, default: false
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
