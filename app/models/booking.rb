class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :box
  has_many :booking_slots, dependent: :destroy
  has_many :slots, through: :booking_slots
  has_one :payment, dependent: :destroy

  validates :status, inclusion: { in: %w[Pending Confirmed Canceled] }
  validates :date, presence: true, comparison: { greater_than_or_equal_to: Date.today }

  def confirm_booking
    update(status: 'Confirmed') if payment&.status == 'succeeded'
  end

end
