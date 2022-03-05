class AddCategoryRefToListings < ActiveRecord::Migration[6.1]
  def change
    add_reference :listings, :category, null: false, foreign_key: true
  end
end
