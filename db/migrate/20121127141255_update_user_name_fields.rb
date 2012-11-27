class UpdateUserNameFields < ActiveRecord::Migration
  def change
  	remove_column :users, :name
  	add_column :users, :fname, :string
  	add_column :users, :lname, :string
  end
end
