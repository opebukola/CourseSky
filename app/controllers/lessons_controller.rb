class LessonsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :finish, :doc]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  before_filter :confirm_complete, only: :finish

  def index
    # @course = Course.find(params[:course_id])
    # @units = @course.units
  end

  def new
    @lesson = Lesson.new
    @course = Unit.find(params[:unit_id]).course
  end

  def create
    @unit = Unit.find(params[:lesson][:unit_id])
    @lesson = @unit.lessons.build(params[:lesson])
    if @lesson.save
      redirect_to edit_unit_path(@lesson.unit), notice: "Lesson Saved!"
    else
      flash[:error] = @lesson.errors.full_messages
      render 'new'
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    @course = @lesson.course
    @comments = @lesson.comments
    @comment = Comment.new
    params[:lesson_id] = params[:id]
    if @lesson.course.status == 'draft'
      redirect_to root_path unless current_user == @lesson.user
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    @course = @lesson.course
  end

  def update
    @lesson = Lesson.find(params[:id])
    @course = @lesson.course
    if @lesson.update_attributes(params[:lesson])
      redirect_to edit_unit_path(@lesson.unit), notice: "Lesson Saved"
    else
      flash[:error] = @lesson.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    Lesson.find(params[:id]).destroy
    redirect_to :back, notice: "Lesson Deleted!"
  end



  def finish
    @lesson = Lesson.find(params[:id])
    @course = @lesson.course
  end

  def sort
    params[:lesson].each_with_index do |id, index|
      Lesson.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  def doc
    @lesson = Lesson.find(params[:id])
  end


  # save lesson question attempts from session to db after login
  # def save
  #   @lesson = Lesson.find(params[:id])
  #   unless session[:attempts].empty?
  #     session[:attempts].each do |question_id, val|
  #       qa = QuestionAttempt.new(question_id: question_id, student_id: current_user.id,
  #                               lesson_id: @lesson.id)
  #       qa.attempts = val[:count]
  #       qa.completed =  val[:correct]
  #       qa.save
  #     end
  #     session.delete(:attempts)
  #   end

  #   flash[:success] = "Your progress has been saved!"

  #   render :json => {:success => true}
  # end


  private

    def correct_user
      @course = Lesson.find(params[:id]).course
      unless current_user == @course.user || current_user.admin?
        flash[:error]= "You are not authorized to perform this action"
        redirect_to @course
      end
    end

    def confirm_complete
      @lesson = Lesson.find(params[:id])
      user = current_or_guest_user
      unless @lesson.completed_by?(user)
        flash[:error] = "You must answer all questions correctly to finish lesson"
        redirect_to :back
      end
    end

end
