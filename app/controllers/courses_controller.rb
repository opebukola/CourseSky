class CoursesController < ApplicationController

	before_filter :authenticate_user!, except: [:index, :show]
	before_filter :correct_user, only: [:edit, :update, :destroy, :manage, :publish]
	before_filter :admin_user, only: [:admin, :feature]

	def index
		@courses = Course.text_search(params[:query]).featured.published.desc
		@categories = Category.main.order(:name)
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
		if @course.feature_status == 'not featured'
			redirect_to root_path unless current_user == @course.user
		end
	end

	def edit
		@course = Course.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])
		if @course.update_attributes(params[:course])
			redirect_to @course, notice: "Course Updated!"
		else
			render 'edit'
		end
	end

	def destroy
		@course = Course.find(params[:id])
		if @course.destroy
			redirect_to root_path, notice: "Course Deleted"
		else
			redirect_to :back, notice: "Cannot delete course"
		end
	end

	def manage
		@course = Course.find(params[:id])
	end

	def publish
		@course = Course.find(params[:id])
		@course.toggle!(:published)
		redirect_to :back, notice: "Course Published!"
	end

	def admin
		@courses = Course.published.desc
	end

	def feature
		@course = Course.find(params[:id])
		@course.toggle!(:featured)
		redirect_to :back, notice: "Course is now featured!"
	end

	def students
		@course = Course.find(params[:id])
	end

	private

		def correct_user
			@course = Course.find(params[:id])
			unless current_user == @course.user || current_user.admin?
				flash[:error] = "You are not authorized to perform this action"
				redirect_to @course
			end
		end
end
