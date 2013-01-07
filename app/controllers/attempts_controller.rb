class AttemptsController < ApplicationController
	def create
		@attempt = Attempt.new(params[:attempt])
		@attempt.user = current_user
		@question = @attempt.question
		@response = @attempt.response.to_s
		if @question.is_correct?@response
			@attempt.correct = true
			if @attempt.save
				respond_to do |format|
					format.html {redirect_to :back, notice: "Correct" }
					format.js {render 'correct'}
				end
			else
				flash[:error] = @attempt.errors.full_messages
				redirect_to :back
			end
		else
			if @attempt.save
				respond_to do |format|
					format.html {redirect_to :back, notice: "Try Again"}
					format.js { render js: "alert('Wrong Answer. Try Again');"}
				end
			else
				redirect_to :back
			end
		end
	end
end
