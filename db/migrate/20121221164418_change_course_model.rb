class ChangeCourseModel < ActiveRecord::Migration
	def change
		add_column :courses, :cover_video, :string
		remove_column :courses, :grade_level_id
		remove_column :courses, :subject_id
		remove_column :courses, :featured
	end
end
