class UnitsController < ApplicationController
	def new
		@course = Course.find(params[:course_id])
		@unit = Unit.new
	end

	def create
		@course = Course.find(params[:unit][:course_id])
		@unit = @course.units.build(params[:unit])
		if @unit.save
			redirect_to manage_course_path(@course), notice: "Unit Saved"
		else
			flash[:error] = @unit.errors.full_messages
			render 'new'
		end
	end

	def edit
		@course = Course.find(params[:course_id])
		@unit = Unit.find(params[:id])
	end

	def update
		@course = Course.find(params[:course_id])
		@unit = Unit.find(params[:id])
		if @unit.update_attributes(params[:unit])
			redirect_to manage_course_path(@course), notice: "Unit saved"
		else
			render 'edit'
		end
	end

	def sort
		params[:unit].each_with_index do |id, index|
			Unit.update_all({position: index+1}, {id: id})
    end
    render nothing: true
	end
end
