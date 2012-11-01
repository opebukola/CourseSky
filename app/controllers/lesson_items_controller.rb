class LessonItemsController < ApplicationController
	def new
		@lesson_item = item_type.new
	end

	def create
		@lesson_item = item_type.new(params[params[:type].downcase])
		if @lesson_item.save
			redirect_to :back, notice: "Item Saved"
		else
			render 'new'
		end
	end

	def show
		@lesson_item = LessonItem.find(params[:id])
		@lesson = @lesson_item.lesson
	end

	def edit
		@lesson_item = LessonItem.find(params[:id])
	end

	def update
		@lesson_item = item_type.find(params[:id])
		if @lesson_item.update_attributes(params[params[:type].downcase])
			redirect_to :back, notice: 'Item Updated'
		else
			render 'edit'
		end
	end

	def destroy
		LessonItem.find(params[:id]).destroy
		redirect_to :back, notice: "Item Deleted"
	end

	def check
		@lesson_item = LessonItem.find(params[:id])
		@lesson = @lesson_item.lesson
		
		if @lesson_item.is_correct?params[:response].downcase
			@lesson_item.mark_complete(current_user) if current_user
			respond_to do |format|
				format.html { redirect_to :back, notice: "Correct" }
				format.js { render 'check_correct'}
			end
		else
			respond_to do |format|
				format.html { redirect_to :back, notice: "Wrong Answer. Try Again"}
				format.js { render 'check_incorrect'}
			end
		end
	end

	def sort
		params[:lesson_item].each_with_index do |id, index|
      LessonItem.update_all({position: index+1}, {id: id})
    end
    render nothing: true
	end

	private
		def item_type
			params[:type].constantize
		end
end


