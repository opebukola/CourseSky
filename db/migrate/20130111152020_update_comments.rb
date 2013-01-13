class UpdateComments < ActiveRecord::Migration
  def change
  	add_column :comments, :concept_id, :integer
  	remove_column :comments, :commentable_id
  	remove_column :comments, :commentable_type
  end
end
