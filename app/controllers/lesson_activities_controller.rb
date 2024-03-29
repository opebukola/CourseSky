class LessonActivitiesController < ApplicationController
	def show
		@activity = LessonActivity.find(params[:id])
		@lesson = @activity.lesson
		@activities = @lesson.lesson_activities
		@course = @lesson.course
		@quiz = Quiz.new
		@attempt = Attempt.new
		@attempt.user = current_user
		@comment = Comment.new
	end

	def edit
		@lesson = Lesson.find(params[:lesson_id])
		@lesson_activity = LessonActivity.find(params[:id])
	end

	def update
		@lesson = Lesson.find(params[:lesson_id])
		@lesson_activity = LessonActivity.find(params[:id])
		if @lesson_activity.update_attributes(params[:lesson_activity])		
			redirect_to :back, notice: "Updated"
		else
			render 'edit'
		end
	end

	def destroy
		LessonActivity.find(params[:id]).destroy
		redirect_to :back, notice: "Removed"
	end

	def sort
		params[:lesson_activity].each_with_index do |id, index|
			LessonActivity.update_all({position: index+1}, {id: id})
    end
    render nothing: true		
	end
end
