class TourDetail < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  has_many :bookings, dependent: :destroy
  validates :price, :numericality => {:greater_than_or_equal_to => 100}
  validates :tour_total, :numericality => {:greater_than_or_equal_to => 1}
  validates :user_id, :numericality => {:greater_than_or_equal_to => 0}
  validates :tour_id, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 1000 }
  validate :validate

  def validate
    errors.add(:time_start, "has already passed") if time_start < Time.zone.now
    errors.add(:time_end, "Time end must after time strat") if time_end <= time_start
    true # never return false or the validation fails
  end
end
