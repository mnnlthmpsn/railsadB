class RegionsController < ApplicationController
  before_action :set_region, only: %i[ show edit update disable_region ]

  # GET /regions or /regions.json
  def index
    @regions = Region.where('active_status=? and del_status=?', true, false)
  end

  # GET /regions/1 or /regions/1.json
  def show;end

  # GET /regions/new
  def new
    @region = Region.new
    respond_to do |f|
      f.js
    end
  end

  # GET /regions/1/edit
  def edit
    respond_to do |f|
      f.js
    end
  end

  # POST /regions or /regions.json
  def create
    @region = Region.new(region_params)
    @regions = Region.where('active_status=? and del_status=?', true, false)
    respond_to do |format|
      if @region.save
        format.js { flash[:success] = "#{@region.region_desc} added successfully" }
        format.html { redirect_to @region, notice: "Region was successfully created." }
        format.json { render :show, status: :created, location: @region }
      else
        format.js { render :new }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regions/1 or /regions/1.json
  def update
    respond_to do |format|
      if @region.update(region_params)
        format.js { flash[:success] = "#{@region.region_desc} updated successfully" }
        format.html { redirect_to @region, notice: "Region was successfully updated." }
        format.json { render :show, status: :ok, location: @region }
      else
        format.js { render :edit }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable_region
    respond_to do |f|
      if @region.update(active_status: false, del_status: true)
        f.js { flash[:success] = "Region deleted successfully" }
      else
        f.js { flash[:error] = "Error deleting Region" }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
  def set_region
    @region = Region.find(params[:id])
  end


    # Only allow a list of trusted parameters through.
  def region_params
    params.require(:region).permit(:region_desc, :comment)
  end
end
