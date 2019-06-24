class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour_detail
  has_many :payments, dependent: :destroy
end
