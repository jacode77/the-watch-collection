class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :buyer, null: false, foreign_key: {to_table: :users} # provides a connection to user_id in the users table but with different name
      t.references :seller, null: false, foreign_key: {to_table: :users}
      t.string :payment_id
      t.string :receipt_url

      t.timestamps
    end
  end
end
