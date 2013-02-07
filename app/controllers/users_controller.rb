class UsersController < ApplicationController

  before_filter :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    @user = User.find(params[:id])
    @courses = Course.text_search(params[:query]).published.desc
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :back, notice: "User deleted"
  end
end
