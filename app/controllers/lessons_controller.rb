class LessonsController < ApplicationController

	before_filter :authenticate_user!, except: [:index, :show]
	before_filter :correct_user, only: [:edit, :update, :destroy, :sort]
	def index
		@course = Course.find(params[:course_id])
		@lessons = @course.lessons.order("position")
	end	

	def new
		@course = Course.find(params[:course_id])
		@lesson = Lesson.new
	end

	def create
		@course = Course.find(params[:course_id])
		@lesson = @course.lessons.build(params[:lesson])
		@lesson.user = current_user
		if @lesson.save
			redirect_to manage_course_path(@course), notice: "Lesson Saved!"
		else
			render 'new'
		end
	end

	def show
		@lesson = Lesson.find(params[:id])
		if @lesson.course.status == 'draft'
			redirect_to root_path unless current_user == @lesson.user
		end
	end

	def edit
		@course = Course.find(params[:course_id])
		@lesson = Lesson.find(params[:id])
	end

	def update
		@course = Course.find(params[:course_id])
		@lesson = Lesson.find(params[:id])
		if @lesson.update_attributes(params[:lesson])
			redirect_to manage_course_path(@course), notice: "Lesson Saved"
		else
			render 'edit'
		end
	end

	def destroy
		@course = Course.find(params[:course_id])
		Lesson.find(params[:id]).destroy
		redirect_to :back, notice: "Lesson Deleted!"
	end

	def sort
		params[:lesson].each_with_index do |id, index|
			Lesson.update_all({position: index+1}, {id: id})
		end
		render nothing: true
	end

	private

		def correct_user
			@course = Course.find(params[:course_id])
			@lesson = Lesson.find(params[:id])
			unless current_user == @lesson.user || current_user.admin?
				flash[:error]= "You are not authorized to perform this action"
				redirect_to @course
			end
		end

end
