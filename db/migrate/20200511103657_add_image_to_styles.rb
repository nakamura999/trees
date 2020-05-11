class AddImageToStyles < ActiveRecord::Migration[5.2]
  def change
    add_column :styles, :image_id, :string
    add_column :styles, :image_second_id, :string
    add_column :styles, :image_third_id, :string
  end
end
