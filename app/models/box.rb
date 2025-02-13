class Box < ApplicationRecord
  belongs_to :boxhouse
  has_many :slots, dependent: :destroy
  has_many :bookings, dependent: :destroy
end
