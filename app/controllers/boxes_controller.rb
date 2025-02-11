class BoxesController < ApplicationController
  before_action :set_box, only: [:show, :edit, :update, :destroy]
  before_action :set_boxhouse

  def index
    @boxes = @boxhouse.boxes.all
  end

  def show

  end

  def new
    @box = @boxhouse.boxes.new
  end

  def create
    @box = @boxhouse.boxes.create(box_params)
    if @box.save
      redirect_to boxhouse_path(@boxhouse), notice: "Box created successfully!"
    else
      render :new, alert: "Failed to create box."
    end
  end

  def edit
  end

  def update
    if @box.update(box_params)
      redirect_to box_path(@box), notice: "Box updated successfully!"
    else
      render :edit, alert: "Failed to update box."
    end
  end

  def destroy
    @boxhouse = @box.boxhouse
    @box.destroy

    redirect_to @boxhouse, notice: "Box deleted successfully!"
  end

  private

  def set_box
    @box = Box.find(params[:id])
  end
  def set_boxhouse
    @boxhouse = Boxhouse.find(params[:boxhouse_id])
  end

  def box_params
    params.require(:box).permit(:name, :box_house_id)
  end
end
