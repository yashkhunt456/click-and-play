class BoxhousesController < ApplicationController
  before_action :find_boxhouse, only: %i[show edit update destroy]

  
  def index
    if user_signed_in? && current_user.has_role?(:boxhouse)
      @boxhouses = current_user.boxhouses
    else
      @boxhouses = Boxhouse.all
    end
  end

  def show
  end

  def new
    @boxhouse = Boxhouse.new
  end

  def create
    @boxhouse = current_user.boxhouses.create(boxhouse_params)
    if @boxhouse.save 
      manage_user_roles
      redirect_to boxhouses_path, notice: "your Boxhouse created successfully. Role : boxhouse"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end
  
  def update
    if @boxhouse.update(boxhouse_params)
      manage_user_roles
      redirect_to @boxhouse, notice: "your Boxhouse is updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @boxhouse.destroy

    redirect_to @boxhouse, notice: "deleted successfully!"
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

  def boxhouse_params
    params.expect(boxhouse: [ :name, :phone, :description, :timing, :address ])
  end
end
