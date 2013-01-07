class ConceptsController < ApplicationController
	def new
		@lesson = Lesson.find(params[:lesson_id])
		@course = @lesson.course
		@concept = Concept.new
	end

	def create
		@lesson = Lesson.find(params[:concept][:lesson_id])
		@course = @lesson.course
		@concept = @lesson.concepts.build(params[:concept])
		if @concept.save
			redirect_to edit_lesson_path(@lesson), notice: "Concept saved"
		else
			flash[:error] = @concept.errors.full_messages
			render 'new'
		end
	end

	def edit
		@concept = Concept.find(params[:id])
		@lesson = @concept.lesson
		@course = @lesson.course
	end

	def update
		@concept = Concept.find(params[:id])
		@lesson = @concept.lesson
		@course = @lesson.course
		if @concept.update_attributes(params[:concept])
			redirect_to edit_lesson_path(@lesson), notice: "Concept saved"
		else
			flash[:error] = @concept.errors.full_messages
			render 'edit'
		end
	end
end
