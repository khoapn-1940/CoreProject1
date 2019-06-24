class TourDetail < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  has_many :bookings, dependent: :destroy
end
