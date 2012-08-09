class CourseReviewsController < ApplicationController
	def index
		@course = Course.find(params[:course_id])
		@course_reviews = @course.course_reviews
	end

	def new
		@course_review = CourseReview.new
	end

	def create
		@course_review = current_user.course_reviews.new(params[:course_review])
		if @course_review.save
			redirect_to course_path(@course_review.course), notice: 'Thanks for the review!'
		else
			render 'new', notice: "Could not save review"
		end
	end

	def edit
		@course_review = current_user.course_reviews.find_by_course_id(params[:course_id])
	end

	def update
		@course_review = current_user.course_reviews.find(params[:id])
		if @course_review.update_attributes(params[:course_review])
			redirect_to course_path(@course_review.course), notice: "Review updated!"
		else
			render 'edit'
		end
	end

end
