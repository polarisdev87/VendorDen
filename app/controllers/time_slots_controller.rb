class TimeSlotsController < ApplicationController

  before_action :authenticate_user!

  def index
    @time_slots = current_shop.time_slots

    respond_to do |format|
      format.json
    end
  end
end
