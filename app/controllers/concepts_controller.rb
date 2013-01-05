class ConceptsController < ApplicationController
	def new
		@lesson = Lesson.find(params[:concept][:lesson_id])
		@concept = Concept.new
	end

	def create
		@lesson = Lesson.find(params[:concept][:lesson_id])
		@concept = @lesson.concepts.build(params[:concept])
		if @concept.save
			redirect_to :back, notice: "Concept saved"
		else
			flash[:error] = @concept.errors.full_messages
			render 'new'
		end
	end

	def edit
		@concept = Concept.find(params[:id])
	end

	def update
		@concept = Concept.find(params[:id])
		if @concept.update_attributes(params[:concept])
			redirect_to :back, notice: "Concept saved"
		else
			flash[:error] = @concept.errors.full_messages
			render 'edit'
		end
	end
end
