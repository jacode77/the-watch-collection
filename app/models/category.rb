class Category < ApplicationRecord
    has_many :listings_categories
    has_many :listings, through: :listings_categories

end
