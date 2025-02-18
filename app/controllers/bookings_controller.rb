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

  

  # <h5 class="mt-4">Bookings for <%= @box.name %></h5>
  # <% if @bookings.any? %>
  #   <table class="table table-bordered table-hover mt-2">
  #     <thead class="thead-dark">
  #       <tr>
  #         <th scope="col">Box</th>
  #         <th scope="col">Date</th>
  #         <th scope="col">Start Time</th>
  #         <th scope="col">Status</th>
  #         <th scope="col" colspan="3">Actions</th>
  #       </tr>
  #     </thead>
  #     <tbody>
  #       <% @bookings.each do |booking| %>
  #         <tr>
  #           <td><%= booking.box.name %></td>
  #           <td><%= booking.date %></td>
  #           <td><%= booking.slots.first.start_time.strftime("%I:%M %p") %></td>
  #           <td><%= booking.status %></td>
  #           <td>
  #             <%= link_to "Show", boxhouse_box_booking_path(@boxhouse, @box, booking), class: "btn btn-sm btn-info" %>
  #           </td>
  #           <td>
  #             <%= link_to "Edit", edit_boxhouse_box_booking_path(@boxhouse, @box, booking), class: "btn btn-sm btn-warning" %>
  #           </td>
  #           <td>
  #             <%= button_to "Cancel", boxhouse_box_booking_path(@boxhouse, @box, booking), method: :delete, class: "btn btn-sm btn-danger", data: { confirm: "Are you sure?" } %>
  #           </td>
  #         </tr>
  #       <% end %>
  #     </tbody>
  #   </table>
  # <% else %>
  #   <p class="text-center mt-3">No bookings have been made for this box yet.</p>
  # <% end %>
  # <%= link_to "<< Back", boxhouse_box_path(@boxhouse, @box), class: "btn btn-sm btn-primary" %>




  # before_action :set_boxhouse_and_box, only: [:new, :create]
  # before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # def index
  #   if current_user.has_role?(:player)
  #     @bookings = current_user.bookings.all
  #   else
  #     @bookings = @box.bookings
  #   end
  # end

  # def show
  # end

  # def new
  #   @booking = @box.bookings.new
  # end

  # def create
  #   @booking = @box.bookings.new(booking_params)
  #   @booking.user = current_user

  #   if @booking.save
  #     redirect_to [@boxhouse, @box, @booking], notice: "Booking was successfully created."
  #   else
  #     render :new
  #   end
  # end

  # def edit
  # end

  # def update
  #   if @booking.update(booking_params)
  #     redirect_to [@boxhouse, @box, @booking], notice: "Booking was successfully updated."
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @booking.destroy
  #   redirect_to boxhouse_box_bookings_path(@boxhouse, @box), notice: "Booking was successfully deleted."
  # end

  # private

  # def set_boxhouse_and_box
  #   @boxhouse = Boxhouse.find(params[:boxhouse_id])
  #   @box = @boxhouse.boxes.find(params[:box_id])
  # end

  # def set_booking
  #   @booking = Booking.find(params[:id])
  # end

  # def booking_params
  #   params.require(:booking).permit(:start_time, :end_time, :status, :date, slot_ids: [])
  # end

end
