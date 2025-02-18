class SlotsController < ApplicationController
  before_action :set_boxhouse_box, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_slot, only: [:show, :edit, :update, :destroy]

  def index
    @slots = @box.slots.all
  end

  def show

  end

  def new
    @slot = @box.slots.new
  end

  def create
    @slot = @box.slots.new(slot_params)
    if @slot.save
      redirect_to boxhouse_box_path(@boxhouse, @box), notice: "Slot created successfully."
    else
      render :new, alert: "Failed to create slot."
    end
  end

  def edit
  end

  def update
    if @slot.update(slot_params)
      redirect_to boxhouse_box_path(@boxhouse, @box), notice: "Slot updated successfully."
    else
      render :edit, alert: "Failed to update slot."
    end
  end

  def destroy
    @slot.destroy
    redirect_to boxhouse_box_path(@boxhouse, @box), notice: "Slot was successfully deleted."
  end

  private
  def set_boxhouse_box
    @boxhouse = Boxhouse.find(params[:boxhouse_id])
    @box = Box.find(params[:box_id])
  end

  def set_slot
    @slot = @box.slots.find_by(id: params[:id])
  end

  def slot_params
    params.require(:slot).permit(:slot_number, :start_time, :end_time, :price)
  end
end
