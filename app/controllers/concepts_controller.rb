class ConceptsController < ApplicationController
	def new
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
end
