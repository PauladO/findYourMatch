Rails.application.routes.draw do
  resources :matches
  root to: "users#index"

  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :update, :show]

  post '/matches/generate', to: 'matches#generate', as: :generate

end
