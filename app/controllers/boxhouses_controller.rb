class BoxhousesController < ApplicationController
  before_action :find_boxhouse, only: %i[show edit update destroy]
  after_action :manage_user_roles_after_destroy, only: :destroy

  def index
    if user_signed_in? && current_user.has_role?(:boxhouse)
      @q = current_user.boxhouses.ransack(params[:q])
      @boxhouses = @q.result.page(params[:page]).per(6)
    else
      @q = Boxhouse.ransack(params[:q])
      @boxhouses = @q.result.page(params[:page]).per(6)
    end
  end

  def show
    # Fetch the Boxhouse and its associated Boxes
    @boxes = @boxhouse.boxes
    # For each box, get the confirmed bookings and the associated feedbacks
    @feedbacks = Feedback.joins(booking: :box)
                         .where(boxes: { boxhouse_id: @boxhouse.id })
                         .order('feedbacks.created_at DESC')
  end

  def new
    @boxhouse = Boxhouse.new
  end

  def create
    @boxhouse = current_user.boxhouses.create(boxhouse_params)
    authorize @boxhouse

    if @boxhouse.save
      manage_user_roles
      redirect_to boxhouses_path, notice: "Your Boxhouse was created successfully. Role: boxhouse"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @boxhouse
  end

  def update
    authorize @boxhouse

    if @boxhouse.update(boxhouse_params)
      manage_user_roles
      redirect_to @boxhouse, notice: "Your Boxhouse was updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @boxhouse
    @boxhouse.destroy
    redirect_to boxhouses_path, notice: "Deleted successfully!"
  end

  private

  def find_boxhouse
    @boxhouse = Boxhouse.find(params[:id])
  end

  def manage_user_roles
    current_user.remove_role(:player)
    return if current_user.has_role?(:boxhouse)
    current_user.add_role(:boxhouse)
  end

  def manage_user_roles_after_destroy
    if current_user.boxhouses.empty?
      current_user.remove_role(:boxhouse)
      current_user.add_role(:player)
    end
  end

  def boxhouse_params
    params.require(:boxhouse).permit(:name, :phone, :description, :timing, :address, :image)
  end
end
