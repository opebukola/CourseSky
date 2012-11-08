class QuestionsController < ApplicationController

  before_filter :admin_user, only: [:new, :create, :destroy, :update, :edit]

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      redirect_to :back, notice: "Question saved"
    else
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      redirect_to :back, notice: "Question updated"
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

   unless current_user
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
        format.html{ redirect_to :back, notice: "Correct!"}
        format.js { render 'check_correct'}
      end
    else
      if current_user
        @question.mark_incorrect(current_user)
      else
      end
      respond_to do |format|
        format.html {redirect_to :back, notice: "Wrong Answer. Try Again"}
        format.js { render 'check_incorrect'}
      end
    end
  end
end

