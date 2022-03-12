class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  # belongs_to :category # may need to delete as the relationship is has_may
  has_many :listings_categories, dependent: :destroy # this action ensures if we delete a listing it also deletes the related categories saved in the join table
  has_many :categories, through: :listings_categories

  has_one_attached :picture
end