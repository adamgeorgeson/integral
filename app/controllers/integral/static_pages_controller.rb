require_dependency "integral/application_controller"

module Integral
  # Static (not related to a specific model) pages
  class StaticPagesController < ApplicationController
    before_action :authenticate_user!

    # GET /
    # Dashboard to show website stats and other useful information
    def dashboard
    end
  end
end
