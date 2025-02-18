class FeedbacksController < ApplicationController
  before_action :set_boxhouse
  before_action :set_box
  before_action :set_booking
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:create, :update, :destroy]

  def index
    if current_user.has_role?(:player) || current_user.has_role?(:boxhouse)
      @feedback = @booking.feedback # Use singular instead of .feedbacks
    elsif current_user.has_role?(:admin)
      @feedbacks = Feedback.all
    else
      redirect_to root_path, alert: 'You do not have permission to view feedbacks.'
    end
  end

  def show
 
  end

  def new
    @feedback = @booking.build_feedback
  end

  def create
    @feedback = @booking.build_feedback(feedback_params)
    if @feedback.save
      redirect_to @boxhouse, notice: 'Feedback was successfully created.'
    else
      render :new
    end
  end

  def edit
    redirect_to [@boxhouse, @box, @booking, @feedback], alert: 'You do not have permission to edit this feedback.' unless can_edit_feedback?
  end

  def update
    if @feedback.update(feedback_params)
      redirect_to [@boxhouse, @box, @booking, @feedback], notice: 'Feedback was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if current_user.has_role?(:admin) || (current_user.has_role?(:player) && feedback_belongs_to_user?(@feedback))
      @feedback.destroy
      redirect_to boxhouse_path(@boxhouse), notice: 'Feedback was successfully destroyed.'
    else
      redirect_to feedbacks_path, alert: 'You do not have permission to delete this feedback.'
    end
  end

  private

  def set_boxhouse
    @boxhouse = Boxhouse.find(params[:boxhouse_id])
  end

  def set_box
    @box = @boxhouse.boxes.find(params[:box_id])
  end

  def set_booking
    @booking = @box.bookings.find(params[:booking_id])
  end

  def set_feedback
    @feedback = @booking.feedback
  end

  def feedback_params
    params.require(:feedback).permit(:rating, :comment)
  end

  def feedback_belongs_to_user?(feedback)
    feedback.booking.user == current_user || feedback.booking.box.boxhouse.user == current_user
  end
  

  def can_edit_feedback?
    @feedback.booking.user == current_user || current_user.has_role?(:admin)
  end

  # Optional: Simplify check_permission or remove it
  def check_permission
    unless current_user.has_role?(:player) || current_user.has_role?(:boxhouse) || current_user.has_role?(:admin)
      redirect_to root_path, alert: 'You do not have permission to view feedbacks.'
    end
  end
end
