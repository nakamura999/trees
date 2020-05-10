class AddStatusToStyles < ActiveRecord::Migration[5.2]
  def change
    add_column :styles, :status, :integer
    add_column :styles, :menu, :string
    add_column :styles, :color_style, :string
  end
end
