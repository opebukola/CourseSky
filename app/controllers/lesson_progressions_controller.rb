class LessonProgressionsController < ApplicationController
	before_filter :correct_user
	def complete
		@lesson_progression = current_user.lesson_progressions.find_by_enrolled_course_id_and_enrolled_lesson_id(
			params[:enrolled_course_id], params[:enrolled_lesson_id])
		@lesson_progression.toggle!(:completed)
		redirect_to :back, notice: "Lesson marked complete"
	end

	private

		def correct_user
			@course = Course.find(params[:enrolled_course_id])
			unless current_user && current_user.enrolled?(@course)
				redirect_to :back, notice: "You must be enrolled in this course to save your progress"
			end
		end
end
