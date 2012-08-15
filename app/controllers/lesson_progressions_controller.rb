class LessonProgressionsController < ApplicationController
	def complete
		@lesson_progression = current_user.lesson_progressions.find_by_enrolled_course_id_and_enrolled_lesson_id(
			params[:enrolled_course_id], params[:enrolled_lesson_id])
		@lesson_progression.toggle!(:completed)
		redirect_to :back, notice: "Lesson marked complete"
	end
	# def complete
	# 	@lesson_progression = LessonProgression.where(
	# 										'student_id = ? AND enrolled_course_id = ? AND 
	# 										enrolled_lesson_id = ?', params[:user_id],
	# 										params[:course_id], params[:lesson_id])
	# 	@lesson_progression.mark_complete
	# 	redirect_to :back, notice: "Lesson marked complete"
	# end
end
