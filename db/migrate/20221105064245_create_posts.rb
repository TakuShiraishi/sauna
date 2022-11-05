class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :sauna_id, null: false
      t.integer :user_id, null: false
      t.text :content, null: false
      t.integer :star, null: false


      t.timestamps
    end
  end
end
