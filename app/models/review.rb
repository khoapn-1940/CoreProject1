class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  has_many :likes, dependent: :destroy
  validates :content,  presence: true,
  length: {maximum: Settings.description_maximum_length}
  validates :user_id, :numericality => {:greater_than_or_equal_to => 0}
  validates :tour_id, :numericality => {:greater_than_or_equal_to => 0}
end
