class CreateBookingSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :booking_slots do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
