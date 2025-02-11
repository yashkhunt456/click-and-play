class Slot < ApplicationRecord
  belongs_to :box
  has_and_belongs_to_many :bookings

  validates :start_time, :end_time, price, status, presence: true
  validates :status, inclusion: { in: %w[booked available] }
  validate :end_time_after_start_time, on: [:create, update]

  private

  def end_time_after_start_time
    errors.add(:end_time, "must be after the start time") if end_time <= start_time
  end
end
