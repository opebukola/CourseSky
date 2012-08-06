class CategoriesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :admin_user

	def index
		@subjects = Subject.order("name")
	end

	def show
		@category = Category.find(params[:id])
		@courses = @category.courses.featured.published.desc
		@subjects = Subject.order("name")
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params[:category])
		if @category.save
			redirect_to categories_path
		else
			render 'new'
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			redirect_to categories_path, notice: "Category Updated!"
		else
			render 'edit'
		end
	end

	def destroy
		Category.find(params[:id]).destroy
		redirect_to categories_path, notice: "Category Deleted"

	end
end
