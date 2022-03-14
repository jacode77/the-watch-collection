class RemoveColumnFromListings < ActiveRecord::Migration[6.1]
  def change
    remove_column :listings, :category_id, :string
  end
end
