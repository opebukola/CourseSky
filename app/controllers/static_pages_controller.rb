class StaticPagesController < ApplicationController
	def home
		@courses = Course.featured.published.desc.limit(6)
		@subjects = Subject.order("name")
	end

	def about
	end

	def contact
	end

	def teach
	end
end
