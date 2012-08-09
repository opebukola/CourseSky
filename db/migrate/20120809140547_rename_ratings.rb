class RenameRatings < ActiveRecord::Migration
  def change
  	rename_table :course_ratings, :course_reviews
  end
end
