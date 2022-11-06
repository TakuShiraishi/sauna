class CreateSaunas < ActiveRecord::Migration[6.1]
  def change
    create_table :saunas do |t|
      t.integer :favorite_id
      t.integer :user_id
      t.string :name, null: false
      t.integer :temperature, null: false
      t.string :place, null: false
      t.date :holiday, null: false
      t.string :prefecture, null: false
      t.string :post_code, null: false
      t.string :address, null: false
      t.integer :price, null: false
      t.time :time, null: false
      t.timestamps
    end
  end
end
