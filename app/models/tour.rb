class Tour < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :tour_details, dependent: :destroy
  has_many :bookings, through: :tour_details
  has_many :payments, through: :bookings
  validates :user_id, :numericality => {:greater_than_or_equal_to => 0}
  validates :category_id, :numericality => {:greater_than_or_equal_to => 0}
  validates :name,  presence: true,
  length: {maximum: Settings.name_maximum_length}
  validates :description,  presence: true,
  length: {maximum: Settings.description_maximum_length}
end
