class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bio, :text
    add_column :users, :avatar, :string
    add_column :users, :phone, :string
    add_column :users, :position, :string
  end
end
