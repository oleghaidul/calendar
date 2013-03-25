class PeriodsController < ApplicationController
  load_and_authorize_resource

  respond_to :js
end
