class CreateSalons < ActiveRecord::Migration[5.2]
  def change
    create_table :salons do |t|
      t.string :salon_name
      t.text :salon_address
      t.string :salon_phone
      t.integer :user_id
      t.string :salon_image_id

      t.timestamps
    end
  end
end
