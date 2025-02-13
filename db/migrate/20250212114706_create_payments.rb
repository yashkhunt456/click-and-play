class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :booking, null: false, foreign_key: true
      t.string :stripe_payment_id, null: false
      t.string :status, null: false
      t.integer :amount, null: false

      t.timestamps
    end

  end
end
