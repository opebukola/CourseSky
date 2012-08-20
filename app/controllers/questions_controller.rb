class QuestionsController < ApplicationController
	def check_correct
		@question = Question.find(params[:id])
		respond_to do |format|
			if @question.correct_answers.include? params[:response].downcase
				flash[:success] = "You are correct!"
				format.html { redirect_to :back}
				format.js
			else
				flash[:error] = "Sorry, that's not the correct answer. Try again!"
				format.html { redirect_to :back}
				format.js
			end
		end
	end
end

