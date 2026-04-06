module Instructor
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_instructor!
    layout "instructor"
  end
end
