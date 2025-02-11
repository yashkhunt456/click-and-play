class CreateBookingsSlotsJoinTable < ActiveRecord::Migration[8.0]
  def change
    create_join_table :bookings, :slots do |t|
      t.index [:booking_id, :slot_id], unique: true
      t.index [:slot_id, :booking_id]
    end
  end
end
