class Boxhouse < ApplicationRecord
  belongs_to :user

  validates :name, :phone, :description, :timing, presence: true
  validates :phone, numericality: { only_integer: true }, length: { is: 10 }, uniqueness: { message: "this phone number is already exist!"}
end
