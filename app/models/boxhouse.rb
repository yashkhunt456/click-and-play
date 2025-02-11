class Boxhouse < ApplicationRecord
  belongs_to :user
  has_many :boxes, dependent: :destroy
  # has_many :slots, through: :boxes
  # has_many :bookings, through: :slots
  # has_many :payments, through: :bookings

  validates :name, :phone, :description, :timing, presence: true
  validates :phone, numericality: { only_integer: true },
   length: { is: 10 }, uniqueness: { message: "this phone number is already exist!"}

   after_create :assign_boxhouse_role

   private

   def assign_boxhouse_role
    self.user.add_role(:boxhouse)
   end

end
