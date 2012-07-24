class AddFeaturedToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :featured, :boolean, default: false
  end
end
