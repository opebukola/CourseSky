class AddInstructorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :instructor, :boolean, default: false
  end
end
