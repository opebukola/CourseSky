class EnrollmentsController < ApplicationController
  def create
    @course = Course.find(params[:enrollment][:enrolled_course_id])
    current_user.enroll!(@course)
    respond_to do |format|
      format.html { redirect_to :back, notice: "Enrolled!" }
      format.js
    end
  end

  def destroy
    @course = Enrollment.find(params[:id]).enrolled_course
    current_user.withdraw!(@course)
    respond_to do |format|
      format.html { redirect_to @course }
      format.js
    end
  end
end
