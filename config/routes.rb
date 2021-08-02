Rails.application.routes.draw do
  devise_for :users
  resources :contacts
  resources :courses
  resources :regions do
    resources :cities do
      resources :towns
    end
  end
  root 'welcome#index'

  #ajax helpers
  get 'city_list' => 'cities#city_list'
  get 'town_list' => 'towns#town_list'

  # filter
  get 'new_filter' => 'welcome#new_filter'
  post 'apply_filter' => 'welcome#apply_filter'

  # posts
  post 'disable_region' => 'regions#disable_region'
  post 'disable_city' => 'cities#disable_city'
  post 'disable_town' => 'towns#disable_town'
  post 'disable_contact' => 'contacts#disable_contact'
end
