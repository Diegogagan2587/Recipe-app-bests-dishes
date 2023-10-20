class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  # we need to validate the presence of the name, measurement_unit, price and quantity attributes
  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
