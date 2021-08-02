class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update disable_contact ]

  # GET /contacts or /contacts.json
  def index
    @contacts = Contact.where(active_status: true, del_status: false)
  end

  # GET /contacts/1 or /contacts/1.json
  def show
    respond_to do |f|
      f.js
    end
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @regions = Region.where(active_status: true, del_status: false)

    respond_to do |f|
      f.js
    end
  end

  # GET /contacts/1/edit
  def edit
    @regions = Region.where(active_status: true, del_status: false)
    @cities = City.where(region_id: @contact.town.city.region.id)
    @towns = Town.where(city_id: @contact.town.city.id)

    # default values
    @selected_region = @contact.town.city.region
    @selected_city = @contact.town.city
    @selected_town = @contact.town

    respond_to do |f|
      f.js
    end
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contacts = Contact.where(active_status: true, del_status: false).order('first_name ASC')
    @regions = Region.where(active_status: true, del_status: false)
    respond_to do |format|
      if @contact.save
        flash.now[:notice] = "#{@contact.get_full_name} added successfully"
        format.js
      else
        # flash.now[:alert] = "Error adding contact"
        logger.info "Error Messages :: #{@contact.errors.messages.inspect}"
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.js { flash[:success] = "Contact Updated successfully" }
      else
        format.js { render :edit }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def disable_contact
    respond_to do |f|
      if @contact.update(active_status: false, del_status: true)
        @success = true
        f.js { flash[:success] = 'Contact deleted successfully' }
      else
        @success = false
        logger.info "Error Messages :: #{@contact.errors.messages.inspect}"
        f.js { flash[:error] = 'Error deleting Contact' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :contact_number, :active_status, :del_status, :region, :city, :town_id)
  end
end
