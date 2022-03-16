class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  # belongs_to :category # may need to delete as the relationship is has_may
  has_many :listings_categories, dependent: :destroy # the dependent action ensures if we delete a listing it also deletes the related categories saved in the join table
  has_many :categories, through: :listings_categories
  accepts_nested_attributes_for :listings_categories

  has_one_attached :picture

  # validations. Certain params are not included such as picture. Will review later to ensure on first post this is inclded but update is not
  validates :brand_id, :model, :condition, :movement, :case_details, :strap, :year, :price, :description, presence: true
  validates :year, length: {is: 4}, numericality: { only_integer: true }

  # data sanitisation to control data going into database and presented in view
  before_save :remove_whitespace
  before_save :remove_fullstop
  before_update :remove_whitespace
  before_update :remove_fullstop
  before_validation :convert_price_to_cents, if: :price_changed?

  private

  # Removes whitespace before/after text in string
  def remove_whitespace
    self.model = self.model.strip
    self.condition = self.condition.strip
    self.movement = self.movement.strip
    self.case_details = self.case_details.strip
    self.strap = self.strap.strip
    self.description = self.description.strip
  end

  # Removes fullstop ad the end of a sentence to appear tidier in view
  def remove_fullstop
    self.model = self.model.chomp('.')
    self.condition = self.condition.chomp('.')
    self.movement = self.movement.chomp('.')
    self.case_details = self.case_details.chomp('.')
    self.strap = self.strap.chomp('.')
    self.description = self.description.chomp('.')
  end

  # Converts price to cents when hitting the database
  def convert_price_to_cents
    self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
  end
end