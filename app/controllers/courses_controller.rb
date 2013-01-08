class CoursesController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show, :lessons]
  before_filter :correct_user, only: [:edit, :update, :destroy, :manage, :publish]
  before_filter :admin_user, only: [:admin, :feature]
  before_filter :instructor, only: [:new, :create]

  def index
    @courses = Course.text_search(params[:query]).published.desc
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(params[:course])
    if @course.save
      redirect_to manage_course_path(@course), notice: "Course Saved!"
    else
      render 'new'
    end
  end

  def show
    @course = Course.find(params[:id])
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

  def lessons
    @course = Course.find(params[:id])
    @units = @course.units
  end

  def manage
    @course = Course.find(params[:id])
    @units = @course.units.order(:position)
  end

  def publish
    @course = Course.find(params[:id])
    @course.toggle!(:published)
    redirect_to :back, notice: "Course Published!"
  end

  def admin
    @courses = Course.published.desc
  end

  def students
    @course = Course.find(params[:id])
  end

  def progress
    @course = Course.find(params[:id])
  end

  def practice
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
