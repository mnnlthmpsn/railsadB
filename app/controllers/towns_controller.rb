class TownsController < ApplicationController
  before_action :set_town, only: %i[show edit update disable_town]

  # GET /towns/1 or /towns/1.json
  def show
    respond_to do |f|
      f.js
    end
  end

  # GET /towns/new
  def new
    @region = Region.find(params[:region_id])
    @city = City.find(params[:city_id])
    @town = Town.new
    respond_to do |f|
      f.js
    end
  end

  # GET /towns/1/edit
  def edit
    @city = City.find(params[:city_id])
    @region = @city.region
    respond_to do |f|
      f.js
    end
  end

  # POST /towns or /towns.json
  def create
    @region = Region.find(params[:region_id])
    @city = City.find(params[:city_id])
    @town = @city.towns.create(town_params)

    respond_to do |f|
      if @town.save
        f.js { flash[:success] = "#{@town.town_desc} added successfully" }
      else
        f.js { render :new }
      end
    end
  end

  # PATCH/PUT /towns/1 or /towns/1.json
  def update
    respond_to do |f|
      if @town.update(town_params)
        f.js { flash[:success] = "#{@town.town_desc} updated successfully" }
      else
        f.js { render :edit }
      end
    end
  end

  def disable_town
    respond_to do |f|
      if @town.update(active_status: false, del_status: true)
        f.js
      else
        f.js
      end
    end
  end

  def town_list
    temp = Town.where(city_id: params[:city_id])
    @towns = temp.map { |town| [town.town_desc, town.id] }.sort_by(&:first).insert(0, 'Select Town')
    respond_to do |f|
      f.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_town
    @town = Town.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def town_params
    params.require(:town).permit(:town_desc, :comment, :city_id, :active_status, :del_status)
  end
end
