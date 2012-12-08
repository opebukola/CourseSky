class AddQuestionImageToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :question_image, :string
  	add_column :questions, :explanation_video, :string
  	rename_column :questions, :explanation, :explanation_text
  end
end
