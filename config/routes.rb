Rails.application.routes.draw do
  resources :events, only: [:index, :new, :destroy,:edit, :update]
  post "events/create", to: "events#create", as: :create_event
  get "event/search/", to: "events#search"
  get 'bands/edit'
  devise_for :admins
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }


  get "dashboard", to: "dashboard#index", as: :dashboard
  get "/", to: "landing_page#index"
  resources :users
  resources :bands
  get "bands/which_edit", to: "bands#which_edit", as: :bands_which_edit
  get "calendar", to: "events#calendar", as: :calendar
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
