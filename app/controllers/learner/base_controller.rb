module Learner
  class BaseController < ApplicationController
    before_action :authenticate_user!
    layout "learner"
  end
end
