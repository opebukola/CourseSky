class QuestionsController < ApplicationController

  before_filter :admin_user, only: [:new, :create, :destroy, :update, :edit]

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])
    @course = @question.lesson.course
    if @question.save
      redirect_to manage_course_path(@course), notice: "Question saved"
    else
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
    @lesson = @question.lesson
    @course = @question.lesson.course
    @comments = @lesson.comments
    @comment = current_user.comments.build if current_user
    params[:lesson_id] = @lesson.id

  if pjax_request?
    render :partial =>  "shared/question_box"
  end
  end

  def edit
    @question = Question.find(params[:id])
    @lesson = @question.lesson
    @course = @question.lesson.course
  end

  def update
    @question = Question.find(params[:id])
    @course = @question.lesson.course
    if @question.update_attributes(params[:question])
      redirect_to manage_course_path(@course), notice: "Question updated"
    else
      render 'edit'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to :back, notice: "Question Deleted"
  end

  def check
    @question = Question.find(params[:id])
    @lesson = @question.lesson
    @comment = Comment.new

    if current_user
      @question.update_attempts(current_user)
    else
      session[:attempts] ||= {}
      session[:attempts][@question.id] ||= {count: 0, correct: false}
      session[:attempts][@question.id][:count] += 1
    end

    if @question.is_correct?params[:response].downcase
      if current_user
        @question.mark_correct(current_user)
      else
        session[:attempts][@question.id][:correct] = true
      end

      respond_to do |format|
        format.html{ redirect_to :@question.next_question, notice: "Correct!"}
        format.js { render 'check_correct'}
      end
    else
      respond_to do |format|
        format.html {redirect_to :back, notice: "Try Again"}
        format.js { render 'check_incorrect'}
      end
    end
  end

  def reveal
    format.html{ redirect_to :@question.next_question, notice: "Next Question"}
      format.js { render 'check_correct'}
  end
end

