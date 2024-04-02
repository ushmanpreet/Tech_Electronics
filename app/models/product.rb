class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  validates :price, numericality: { greater_than_or_equal_to: 0, message: "must be a valid decimal number" }
  has_one_attached :image
  attr_accessor :image_url
  attr_accessor :category_name

  scope :search_by_keyword, ->(keyword) {
    where("product_name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
  }
end
