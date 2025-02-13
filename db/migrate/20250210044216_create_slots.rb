class CreateSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :slots do |t|
      t.integer :slot_number
      t.datetime :start_time
      t.datetime :end_time
      t.integer :price
      t.string :status, default: "Available", null: false
      t.references :box, null: false, foreign_key: true

      t.timestamps
    end
  end
end
