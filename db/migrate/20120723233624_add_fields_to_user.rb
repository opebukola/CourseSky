class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :avatar, :string
    add_column :users, :name, :string
    add_column :users, :location, :string
    add_column :users, :about, :text
  end
end
