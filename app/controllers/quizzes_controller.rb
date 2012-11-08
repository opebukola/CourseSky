class QuizzesController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		@quiz = Quiz.new
	end

	def create
		@quiz = current_user.quizzes.build(params[:quiz])
		if @quiz.save
			redirect_to @quiz
		else
			render 'new'
		end
	end

	def show
		@quiz = Quiz.find(params[:id])
		@questions = @quiz.questions.limit(10)
	end

	def skills
		
	end
end
