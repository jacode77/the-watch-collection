class CreateListingsCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :listings_categories do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
