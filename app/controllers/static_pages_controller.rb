class StaticPagesController < ApplicationController
	def home
		@courses = Course.published.desc
	end

	def about
	end

	def contact
	end

	def teach
	end
end
