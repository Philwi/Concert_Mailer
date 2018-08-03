Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }


  get "dashboard", to: "dashboard#index", as: :dashboard
  get "/", to: "landing_page#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
