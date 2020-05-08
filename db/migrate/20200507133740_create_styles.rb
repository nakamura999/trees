class CreateStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :styles do |t|
      t.string :name
      t.text :content
      t.integer :price
      t.string :image_id
      t.integer :jenre_id
      t.integer :user_id

      t.timestamps
    end
  end
end
