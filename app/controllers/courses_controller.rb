class CoursesController < ApplicationController
	def index
		@courses = Course.published.desc
	end

	def new
		@course = Course.new
	end

	def create
		@course = current_user.courses.build(params[:course])
		if @course.save
			redirect_to @course, notice: "Draft Course Saved!"
		else
			render 'new'
		end
	end

	def show
		@course = Course.find(params[:id])
		if @course.status == 'draft'
			redirect_to root_path unless current_user == @course.user
		end
	end

	def edit
		@course = Course.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])
		if @course.update_attributes[params[:course]]
			render @course, notice: "Course Updated!"
		else
			render 'edit'
		end
	end

	def destroy
		Course.find(params[:id]).destroy
		redirect_to root_path, notice: "Course Deleted"
	end

	def manage
		@course = Course.find(params[:id])
	end

	def publish
		@course = Course.find(params[:id])
		@course.toggle!(:published)
		redirect_to :back, notice: "Course Published!"
	end
end
