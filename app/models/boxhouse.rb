  class Boxhouse < ApplicationRecord
    belongs_to :user
    has_many :boxes, dependent: :destroy
    has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_fill: [500, 300]
  end

    validates :name, :phone, :description, :timing, presence: true
    validates :phone, numericality: { only_integer: true },
    length: { is: 10 }, uniqueness: { message: "this phone number is already exist!"}

    after_create :assign_boxhouse_role

    def self.ransackable_attributes(auth_object = nil)
      ["address", "created_at", "name", "updated_at", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
      ["boxes", "image_attachment", "image_blob", "user"]
    end

    def large_image
      image.variant(resize_to_fill: [800, 600]).processed
    end
    

    private

    def assign_boxhouse_role
      self.user.add_role(:boxhouse)
    end

  end
