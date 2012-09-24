class QuestionsController < ApplicationController
	
	def new
		@question = Question.new
	end

	def create
		@question = Question.new(params[:question])
		@course = @question.lesson.course
		if @question.save 
			redirect_to manage_course_path(@course), notice: "Question saved"
		else
			render 'new'
		end
	end
	
	def show
		@question = Question.find(params[:id])
		@lesson = @question.lesson
		@course = @question.lesson.course
		@comments = @lesson.comments
		@comment = current_user.comments.build if current_user
		params[:lesson_id] = @lesson.id
	end

	def edit
		@question = Question.find(params[:id])
		@lesson = @question.lesson
		@course = @question.lesson.course
	end

	def update
		@question = Question.find(params[:id])
		@course = @question.lesson.course
		if @question.update_attributes(params[:question])
			redirect_to manage_course_path(@course), notice: "Question updated"
		else
			render 'edit'
		end
	end

	def destroy
		Question.find(params[:id]).destroy
		redirect_to :back, notice: "Question Deleted"
	end

	def check
		@question = Question.find(params[:id])
		@lesson = @question.lesson
		@comment = Comment.new
		@question.update_attempts(current_user) if current_user
			if @question.is_correct?params[:response].downcase
				@question.mark_correct(current_user) if current_user
				respond_to do |format|
					format.html{ redirect_to :@question.next_question, notice: "Correct!"}
					format.js { render 'check_correct'}
				end
			else
				respond_to do |format|
					format.html {redirect_to :back, notice: "Try Again"}
					format.js { render 'check_incorrect'}
				end
			end
	end
end

