class StaticPagesController < ApplicationController
  before_filter :admin_user, only: :admin
  def home
    @courses = Course.featured.published.desc.limit(6)
    @categories = Category.main.order(:name)
  end

  def about
  end

  def contact
  end

  def teach
  end

  def admin
  end
end
