class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_boxhouse_and_box, only: [:index, :new, :create, :edit, :update, :show, :destroy]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.has_role?(:player)
      @bookings = current_user.bookings.all
    else
      @bookings = @box.bookings
    end
  end

  def show
  end

  def new
    @booking = @box.bookings.new
  end

  def create
    @booking = @box.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      @booking.update(total_price: @booking.slots.sum(:price))
      redirect_to [@boxhouse, @box, @booking], notice: "Booking was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.status == "Confirmed"
      flash[:alert] = "You cannot update a confirmed booking."
      redirect_to [@boxhouse, @box, @booking]
    else
      if @booking.update(booking_params)
        @booking.update(total_price: @booking.slots.sum(:price))
        redirect_to [@boxhouse, @box, @booking], notice: "Booking was successfully updated."
      else
        render :edit
      end
    end
  end

  def destroy
    @booking.destroy
    redirect_to boxhouse_box_bookings_path(@boxhouse, @box), notice: "Booking was successfully deleted."
  end

  private

  def set_boxhouse_and_box
    @boxhouse = Boxhouse.find(params[:boxhouse_id])
    @box = @boxhouse.boxes.find(params[:box_id])
  end

  def set_booking
    @booking = @box.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :status, :date, :total_price, slot_ids: [])
  end


end
