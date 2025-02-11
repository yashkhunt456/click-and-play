class SlotsController < ApplicationController
  before_action :set_slot, only: [:edit, :update, :destroy]

  def new
  end

  def create 
    @box = Box.find(params[:box_id])
    @slot = @box.create(slot_params)

    if @slot.save
      redirect_to @box, notice: "Slot created successfully!"
    else
      render :new, alert: "Failed to create Slot."
    end
  end

  def edit
  end

  def update
    if @slot.update(box_params)
      redirect_to box_path(@slot), notice: "Slot updated successfully!"
    else
      render :edit, alert: "Failed to update Slot."
    end
  end

  def destroy
    @box = @box.boxhouse
    @slot.destroy

    redirect_to @box, notice: "Slot deleted successfully!"
  end

  private

  def set_slot
    @slot = Slot.find(params[:id])
  end

  def slot_params
    params.require(:slot).permit(:start_time, :end_time, :status, :price :box_id)
  end
end
