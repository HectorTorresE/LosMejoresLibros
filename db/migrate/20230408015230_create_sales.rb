class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :book, null: false, foreign_key: true
      t.decimal :price, precision: 10, scale: 2, null: false
      t.boolean :authorpayed, null: false, default: false
      t.datetime :datedpayed
      t.integer :copies, null: false, default: 0
      t.references :user, null: false, foreign_key: { on_delete: :restrict }

      t.timestamps null: false
    end
  end
end
