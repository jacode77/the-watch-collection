class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  belongs_to :category

  # enum brand_id: {"Rolex": 1, "Omega": 2, "Patek Philippe": 3, "Piaget": 4, "Cartier": 5, "Jaeger-LeCoultre": 6}
  has_one_attached :picture
end
