Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :mailings
  resources :bookers
  resources :events, only: [:index, :new, :destroy,:edit, :update]
  post "events/create", to: "events#create", as: :create_event
  get "event/search/", to: "events#search"
  get 'bands/edit'
  post 'kontaktanfrage', to: "contact#mailing", as: :contact_mailing
  devise_for :admins
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  post 'mailings/mailing', to: 'mailings#mailing'

  patch 'bookers/update/:id', to: 'bookers#update'

  get 'charts/email_null', to: 'charts#email_null', as: :email_null_charts
  get 'charts/email_to_booker', to: 'charts#email_to_booker', as: :email_to_booker_charts

  get "dashboard", to: "dashboard#index", as: :dashboard
  get "/", to: "landing_page#index"
  resources :users
  resources :bands
  get "news/index", to: "news#index"
  get "bands/which_edit", to: "bands#which_edit", as: :bands_which_edit
  get "calendar", to: "events#calendar", as: :calendar
  get "not_active", to: "landing_page#not_active"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #match '*path', to: redirect('/'), via: :all
end
