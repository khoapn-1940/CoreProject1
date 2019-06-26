class Category < ApplicationRecord
  has_many :tours, dependent: :destroy
  validates :name,  presence: true,
  length: {maximum: Settings.name_maximum_length}
  validates :description,  presence: true,
  length: {maximum: Settings.description_maximum_length}
end
