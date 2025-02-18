class SlotsController < ApplicationController
  before_action :set_boxhouse_box, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_slot, only: [:show, :edit, :update, :destroy]
  before_action :authorize_slot, only: [:show, :edit, :update, :destroy]

  def index
    @slots = @box.slots.all
  end

  def show
  end

  def new
    @slot = @box.slots.new
    authorize @slot  # Ensure only authorized users can create slots
  end

  def create
    @slot = @box.slots.new(slot_params)
    authorize @slot  # Authorization check

    if @slot.save
      redirect_to boxhouse_box_path(@boxhouse, @box), notice: "Slot created successfully."
    else
      render :new, alert: "Failed to create slot."
    end
  end

  def edit
    authorize @slot  # Ensure only authorized users can edit
  end

  def update
    authorize @slot  # Ensure only authorized users can update
    if @slot.update(slot_params)
      redirect_to boxhouse_box_path(@boxhouse, @box), notice: "Slot updated successfully."
    else
      render :edit, alert: "Failed to update slot."
    end
  end

  def destroy
    authorize @slot  # Ensure only authorized users can delete
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

  def authorize_slot
    authorize @slot if @slot.present?  # Ensure Pundit authorization
  end
end
