class SkillsController < ApplicationController

	before_filter :admin_user, only: [:new, :create, :destroy, :update, :edit]
	
	def index
		@skills = Skill.all
	end

	def new
		@skill = Skill.new(:parent_id => params[:parent_id])
	end

	def create
		@skill = Skill.new(params[:skill])
		if @skill.save
			redirect_to skills_path, notice: "Skill Saved!"
		else
			render 'new'
		end
	end
end
