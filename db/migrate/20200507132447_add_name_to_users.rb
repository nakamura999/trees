class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :kana_name, :string
    add_column :users, :prefectures, :string
    add_column :users, :status, :integer
    add_column :users, :body, :text
    add_column :users, :profile_image_id, :string
  end
end
