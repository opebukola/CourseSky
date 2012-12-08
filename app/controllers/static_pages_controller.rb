class StaticPagesController < ApplicationController
  before_filter :admin_user, only: :admin
  def home
    @courses = Course.published.desc.limit(6)
  end

  def about
  end

  def contact
  end

  def teach
  end

  def admin
  end

  def careers
    
  end
end
