class FixQuestionModel < ActiveRecord::Migration
	def change
		add_column :answers, :question_id, :integer
		remove_column :questions, :mark_as_check
		drop_table :categories
		drop_table :categorizations
		drop_table :completed_asks
		drop_table :answer_asks
		drop_table :answer_questions
		drop_table :grade_levels
		drop_table :lesson_item_skills
		drop_table :lesson_items
		drop_table :quiz_skills
	end
end
