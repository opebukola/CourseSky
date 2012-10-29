class RemoveIntroFromLessons < ActiveRecord::Migration
  def change
  	remove_column :lessons, :intro
  end
end
