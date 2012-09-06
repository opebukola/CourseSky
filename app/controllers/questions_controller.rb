class QuestionsController < ApplicationController
	def show
		@question = Question.find(params[:id])
		@lesson = @question.lesson
		@course = @question.lesson.course
	end

	def check
		@question = Question.find(params[:id])
		@user = current_user
		respond_to do |format|
			format.html{ 
				if @question.has_answer?
					if @question.correct_answers.include?params[:response].downcase
						flash[:success] = "Correct!"
						@question.mark_complete(current_user) if current_user
						redirect_to question_path @question.next_question
					else
						flash[:error] = "That's not the correct answer, try again!"
						redirect_to :back
					end
				else
					flash[:success] = "Great answer!"
					@question.mark_complete(current_user) if current_user
					redirect_to question_path @question.next_question
				end
				}
			format.js 
		end
	end
end

