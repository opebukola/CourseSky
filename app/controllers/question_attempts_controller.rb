class QuestionAttemptsController < ApplicationController
  def destroy
    @question = Question.find(params[:id])
    current_user.reset!(@question)
    respond_to do |format|
      format.html { redirect_to :back}
      format.js
    end
  end
end
