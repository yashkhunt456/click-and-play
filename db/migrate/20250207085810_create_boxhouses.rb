class CreateBoxhouses < ActiveRecord::Migration[8.0]
  def change
    create_table :boxhouses do |t|
      t.string :name
      t.integer :phone
      t.text :description
      t.text :address
      t.string :timing
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
