# Admin namespace base controller
# All controllers inside app/controllers/admin/ inherit from this.
# This means authenticate_user! and require_admin! apply to EVERY admin controller
# without repeating them — the Open/Closed principle in action.
module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!

    # All controllers in the Admin namespace use the 'admin' layout
    # (app/views/layouts/admin.html.erb)
    layout "admin"
  end
end
