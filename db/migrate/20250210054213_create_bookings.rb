class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.string :status, default: "Pending", null: false
      t.date :date, null: false 
      t.integer :total_price, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :box, null: false, foreign_key: true

      t.timestamps
    end
  end
end
