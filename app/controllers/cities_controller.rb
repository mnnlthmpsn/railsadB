class CitiesController < ApplicationController
  before_action :set_city, only: %i[ show edit update disable_city ]

  # GET /cities or /cities.json
  def index
    @cities = City.where(active_status: true, del_status: false)
  end

  # GET /cities/1 or /cities/1.json
  def show
  end

  # GET /cities/new
  def new
    @region = Region.find(params[:region_id])
    @city = City.new
    respond_to do |f|
      f.js
    end
  end

  # GET /cities/1/edit
  def edit
    @region = Region.find(params[:region_id])
    respond_to do |f|
      f.js
    end
  end

  # POST /cities or /cities.json
  def create
    @region = Region.find(params[:region_id])
    @city = @region.cities.create(city_params)

    respond_to do |format|
      if @city.save
        format.js { flash[:success] = "#{@city.city_desc} added successfully" }
      else
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /cities/1 or /cities/1.json
  def update
    @region = Region.find(params[:region_id])
    respond_to do |format|
      if @city.update(city_params)
        format.js
      else
        format.js { render :edit }
      end
    end
  end

  def disable_city
    respond_to do |f|
      if @city.update(active_status: false, del_status: true)
        f.js
      else
        f.js
      end
    end
  end

  def city_list
    temp = City.where(region_id: params[:region_id])
    @cities = temp.map { |city| [city.city_desc, city.id] }.sort_by(&:first).insert(0, 'Select City')
    respond_to do |f|
      f.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_city
    @city = City.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def city_params
    params.require(:city).permit(:city_desc, :region_id, :comment)
  end
end
