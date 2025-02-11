class Booking < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :slots

  validates :status, inclusion: { in: %w[Pending Confirmed Canceled] }
end
