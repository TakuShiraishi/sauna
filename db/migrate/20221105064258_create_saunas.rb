class CreateSaunas < ActiveRecord::Migration[6.1]
  def change
    create_table :saunas do |t|
      t.integer :favorite_id
      t.integer :user_id
      t.string :name, null: false
      t.integer :temperature, null: false
      t.string :place, null: false
      t.string :holiday
      t.string :prefecture
      t.string :post_code
      t.text :comment, null: false
      t.string :address
      t.integer :price
      t.string :time
      t.float :latitude
      t.float :longitude
      t.integer :star, null: false,default: 0
      t.timestamps
    end
  end
end
