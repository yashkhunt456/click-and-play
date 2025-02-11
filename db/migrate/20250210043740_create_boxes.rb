class CreateBoxes < ActiveRecord::Migration[8.0]
  def change
    create_table :boxes do |t|
      t.string :name
      t.references :boxhouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
