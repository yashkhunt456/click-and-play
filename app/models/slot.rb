class Slot < ApplicationRecord
  belongs_to :box
  has_many :booking_slots, dependent: :destroy
  has_many :bookings, through: :booking_slots

  validates :slot_number, presence: true, uniqueness: { scope: :box_id }
  validates :start_time, :end_time, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w[Available Booked Unavailable] }
  validate :end_time_after_start_time, on: [:create, :update]


  private
  def end_time_after_start_time
    if end_time.present? && start_time.present? && end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
