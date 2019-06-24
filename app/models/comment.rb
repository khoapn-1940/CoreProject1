class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  belongs_to :comment, :class_name => "Comment"
  has_many :reply, :class_name => "Comment", :foreign_key => "reply_id", dependent: :destroy
end
