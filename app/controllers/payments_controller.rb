class PaymentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_booking
    before_action :set_boxhouse_and_box
  
    def new
      # Build a new payment object for the booking but don't save it yet
      @payment = @booking.payment || @booking.build_payment(amount: @booking.total_price, status: "pending")
    end
  
    def create
      @payment = @booking.payment # Fetch the existing payment for the booking

      begin
        # Use the amount directly (no need to multiply by 100)
        charge = Stripe::Charge.create(
          amount: @payment.amount,  # amount is already in integer form
          currency: 'usd',
          source: params[:stripeToken],
          description: "Payment for Booking ##{@booking.id}"
        )
  
        # Update payment with the charge ID and status
        @payment.update(
          stripe_payment_id: charge.id,
          status: "succeeded"
        )
  
        # Redirect to the booking page with success message
        redirect_to booking_path(@booking), notice: "Payment successful!"
      rescue Stripe::CardError => e
        # If payment fails, update payment status and show error
        @payment.update(status: "failed")
        flash[:alert] = e.message
        redirect_to new_booking_payment_path(@booking)
      end
    end
  
    private
  
    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def set_boxhouse_and_box
        @boxhouse = Boxhouse.find(params[:boxhouse_id])
        @box = @boxhouse.boxes.find(params[:box_id])
     end
end
  