class QuestionsController < ApplicationController

  before_filter :admin_user, only: [:new, :create, :destroy, :update, :edit]

  def new
    @lesson = Lesson.find(params[:lesson_id])
    @course = @lesson.course
    @question = Question.new
  end

  def create
    @lesson = Lesson.find(params[:question][:lesson_id])
    @course = @lesson.course
    @question = Question.new(params[:question])
    if @question.save
      redirect_to edit_lesson_path(@lesson), notice: "Question saved"
    else
      flash[:error] = @question.errors.full_messages
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
    @lesson = @question.lesson
    @course = @lesson.course
  end

  def update
    @question = Question.find(params[:id])
    @lesson = @question.lesson
    @course = @lesson.course
    if @question.update_attributes(params[:question])
      redirect_to edit_lesson_path(@lesson), notice: "Question updated"
    else
      flash[:error] = @question.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to :back, notice: "Question Deleted"
  end

  def check
    @question = Question.find(params[:id])
    if @question.is_correct?params[:response].downcase
      @question.mark_correct(current_user, params[:response])
      respond_to do |format|
        format.html{ redirect_to :back, notice: "Correct!"}
        format.js { render 'check_correct'}
      end
    else
      @question.mark_incorrect(current_user, params[:response])
      respond_to do |format|
        format.html {redirect_to :back, notice: "Wrong Answer. Try Again"}
        format.js { render 'check_incorrect'}
      end
    end
  end
end

