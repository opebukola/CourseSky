class QuizzesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :correct_user, except: [:new, :create]
	
	def new
		@lesson = Lesson.find(params[:lesson_id])
		@course = @lesson.course
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
		@questions = @quiz.available_questions.limit(5)
		@attempts = @questions.map do |question| 
			a = Attempt.new
			a.question = question
			a.user = current_user
			a.quiz = @quiz
			a
		end
		@lesson = @quiz.lesson
		@course = @lesson.course
	end

	def finish
		@quiz = Quiz.find(params[:id])
		@attempts = @quiz.final_attempts
		@lesson = @quiz.lesson
		@course = @lesson.course
	end

	  private

    def correct_user
      @quiz = Quiz.find(params[:id])
      @course = @quiz.lesson.course
      unless current_user == @quiz.user || current_user.admin?
        flash[:error] = "You cannot view this quiz"
        redirect_to @course
      end
    end
end
