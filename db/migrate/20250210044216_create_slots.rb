class CreateSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :price
      t.string :status
      t.references :box, null: false, foreign_key: true

      t.timestamps
    end
  end
end
