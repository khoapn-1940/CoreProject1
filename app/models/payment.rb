class Payment < ApplicationRecord
  belongs_to :booking
  scope :order_by_time_desc, ->{order(created_at: :desc)}
end
