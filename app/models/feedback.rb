class Feedback < ApplicationRecord
  belongs_to :booking
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, length: { maximum: 500 }, allow_blank: true
end
