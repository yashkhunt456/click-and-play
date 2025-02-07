class BoxhousesController < ApplicationController
  def index
    @boxhouses = Boxhouse.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
