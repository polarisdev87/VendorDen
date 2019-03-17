class Shopify::TimeSlotsController < Shopify::BaseController

  before_action :set_time_slot, only: %i[show edit update destroy]

  def index
    @time_slots = current_shop.time_slots

    respond_to do |format|
      format.json
    end
  end

  def new
    @time_slot = current_shop.time_slots.build
  end

  def create
    @time_slot = current_shop.time_slots.build(time_slot_params)
    if @time_slot.save
      flash.notice = 'Timeslot was successfuly created'
      redirect_to shopify_root_path 'tab' => 'calendar'
    else
      render :new
    end
  end

  def show
    redirect_to edit_shopify_time_slot_path(@time_slot)
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @time_slot.update_attributes(time_slot_params)
      flash.notice = 'Timeslot was successfuly updated'
      redirect_to shopify_root_path 'tab' => 'calendar'
    else
      render :edit
    end
  end

  def destroy
    @time_slot.destroy!
    flash.notice = 'Timeslot was successfuly destroyed'
    redirect_to shopify_root_path 'tab' => 'calendar'
  end

  private

    def set_time_slot
      @time_slot = current_shop.time_slots.find(params[:id])
    end

    def time_slot_params
      params.require(:time_slot).permit(
        :description,
        :start_date,
        :start_time,
        :end_date,
        :end_time
        #:is_all_day
      )
    end
end
