class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true, on_delete: :restrict, index: { where: "users.role = 'author'" }
      t.string :title
      t.string :category
      t.datetime :published_date
      t.decimal :price
      t.decimal :discount
      t.boolean :avilable, null: false, default: true

      t.timestamps
    end
  end
end
