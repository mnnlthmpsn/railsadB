class WelcomeController < ApplicationController

  before_action :authenticate_user!

  def index
    @contacts = Contact.where('active_status=? and del_status=?', true, false).order('first_name ASC')
  end

  def new_filter
    @filter_params = ['Region', 'City', 'Town', 'Date Added']
    temp_reg = Region.where(active_status: true, del_status: false)
    @regions = temp_reg.map { |reg| [reg.region_desc, reg.id] }.sort_by(&:first).insert(0, ['Select Region'])

    temp_cit = City.where(active_status: true, del_status: false)
    @cities = temp_cit.map { |city| [city.city_desc, city.id] }.sort_by(&:first).insert(0, ['Select City'])

    temp_tow = Town.where(active_status: true, del_status: false)
    @towns = temp_tow.map { |town| [town.town_desc, town.id] }.sort_by(&:first).insert(0, ['Select Town'])
    respond_to do |f|
      f.js
    end
  end

  def apply_filter
    fname_param = params[:filter][:firstname]
    lname_param = params[:filter][:lastname]
    cn_param = params[:filter][:contact_number]
    reg_param = params[:filter][:region]
    cit_param = params[:filter][:city]
    tow_param = params[:filter][:town]
    st_date = params[:filter][:start_date]
    en_date = params[:filter][:end_date]

    search_query = []

    search_query << "lower(first_name) LIKE lower('%#{fname_param}%')" if fname_param.present?
    search_query << "lower(last_name) LIKE lower('%#{lname_param}%')" if lname_param.present?
    search_query << "contact_number LIKE '%#{cn_param}%'" if cn_param.present?
    search_query << "region_id = '#{reg_param}'" if reg_param.present?
    search_query << "city_id = '#{cit_param}'" if cit_param.present?
    search_query << "town_id = '#{tow_param}'" if tow_param.present?

    if st_date.present? && en_date.present?
      search_query << "contacts.created_at BETWEEN '#{st_date} 00:00:00' AND '#{en_date} 23:59:59'"
    end

    query_string = search_query.join(' AND ')

    contacts = Contact.joins(town: [{ city: :region }]).where(
      "#{query_string} AND contacts.active_status is ? AND contacts.del_status is ?", true, false
    ).order('first_name ASC')

    respond_to do |f|
      @contacts = if search_query.empty?
                    Contact.where(active_status: true, del_status: false).order('first_name ASC')
                  else
                    contacts
                  end
      f.js
    end
  end

  private

  def model_filter(model)
    model.where(active_status: true, del_status: false)
  end

end