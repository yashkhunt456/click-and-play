class Payment < ApplicationRecord
  belongs_to :booking

  validates :stripe_payment_id, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w[pending succeeded failed] }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
