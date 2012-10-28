class VideosController < ApplicationController
	def new
		@video = Video.new
	end

	def create
		@video = Video.new(params[:video])
		if @video.save
			redirect_to :back
		else
			render 'new'
		end
	end

	def show
		@video = Video.find(params[:id])
	end

	def edit
		@video = Video.find(params[:id])
	end

	def update
		@video = Video.find(params[:id])
		@course = @video.lesson.course
		if @video.update_attributes(params[:video])
			redirect_to manage_course_path(@course), notice: "Video clip saved!"
		else
			render 'edit'
		end
	end

	def destroy
		Video.find(params[:id]).destroy
		redirect_to :back, notice: "Video Clip Deleted"
	end
end
