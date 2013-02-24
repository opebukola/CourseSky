class PagesController < ApplicationController
	before_filter :admin_user, only: :admin

  def home
    @courses = Course.published.desc.limit(6)
  end

  def about
  end

  def how
  end

  def team
  end

  def admin
  end

  def careers
  end

  def terms
  end

  def parents
  end

  def pricing
    
  end
end
