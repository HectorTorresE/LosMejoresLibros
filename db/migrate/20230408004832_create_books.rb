class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.integer :amountsold, null: false, default: 0
      t.boolean :available, null: false, default: true
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
