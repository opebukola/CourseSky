class QuizzesController < ApplicationController
	def new
		@quiz = Quiz.new
	end

	def create
		@quiz = current_user.quizzes.build(params[:quiz])
		if @quiz.save
			redirect_to @quiz, notice: "Quiz Created"
		else
			render 'new'
		end
	end

	def show
		@quiz = Quiz.find(params[:id])
		@questions = @quiz.questions
	end

	def skills
		
	end
end
