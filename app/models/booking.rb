class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour_detail
  has_many :payments, dependent: :destroy
  validates :book_total, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1000 }
  validates :user_id, :numericality => { :greater_than_or_equal_to => 0,}
  validates :tour_detail_id, :numericality => { :greater_than_or_equal_to => 0,}
end
