class RemoveImageFromStyles < ActiveRecord::Migration[5.2]
  def change
    remove_column :styles, :image_id, :string
  end
end
