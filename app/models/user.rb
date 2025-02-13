class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boxhouses, dependent: :destroy
  has_many :bookings

  validates :username, presence: true

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:player) if self.roles.blank?
  end
end
