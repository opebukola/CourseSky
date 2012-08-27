class QuestionsController < ApplicationController
	def check_correct
		@question = Question.find(params[:id])
		respond_to do |format|
			format.html{ 
				if @question.correct_answers.include?params[:response].downcase
					flash[:success] = "Correct!"
					redirect_to :back
				else
					flash[:error] = "That's not the correct answer, try again!"
					redirect_to :back
				end
				}
			format.js 
		end
	end
end

