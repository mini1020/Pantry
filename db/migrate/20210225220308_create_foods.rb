class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :fname, null: false
      t.integer :quantity, null: false
      t.date :purchase, null:false
      t.date :expiration
      t.references :storage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
