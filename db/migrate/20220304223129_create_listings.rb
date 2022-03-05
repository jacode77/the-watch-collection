class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :model
      t.string :condition
      t.string :movement
      t.string :case_details
      t.string :strap
      t.integer :year
      t.integer :price
      t.boolean :authenticity, null: false, default: false
      t.boolean :sold, default: false
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
