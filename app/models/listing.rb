class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  # belongs_to :category # may need to delete as the relationship is has_may
  has_many :listings_categories, dependent: :destroy # the dependent action ensures if we delete a listing it also deletes the related categories saved in the join table
  has_many :categories, through: :listings_categories
  accepts_nested_attributes_for :listings_categories

  has_one_attached :picture

  # validations. Certain params are not included such as picture. Would be ideal to make it only valid on creation but not for updating
  validates :brand_id, :model, :condition, :movement, :case_details, :strap, :year, :price, :description, presence: true
end