class GradeLevelsController < ApplicationController
  def index
    @grade_levels = GradeLevel.all
  end

  def new
    @grade_level = GradeLevel.new
  end

  def create
    @grade_level = GradeLevel.new(params[:grade_level])
    if @grade_level.save
      redirect_to grade_levels_path
    else
      render 'new'
    end
  end

  def edit
    @grade_level = GradeLevel.find(params[:id])
  end

  def update
    @grade_level = GradeLevel.find(params[:id])
    if @grade_level.update_attributes(params[:grade_level])
      redirect_to grade_levels_path, notice: "GradeLevel Updated!"
    else
      render 'edit'
    end
  end

  def destroy
    GradeLevel.find(params[:id]).destroy
    redirect_to grade_levels_path, notice: "GradeLevel Deleted"

  end
end
