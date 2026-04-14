class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  def index
    @courses = policy_scope(Course)
  end

  def show
    authorize @course
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
