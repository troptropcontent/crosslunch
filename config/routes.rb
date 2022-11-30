Rails.application.routes.draw do
  devise_for :users
  class Subdomain
    def self.matches?(request)
      request.subdomain.present? && request.subdomain != 'www'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  constraints Subdomain do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    root 'recurring_events#show'
    resources :participations, only: %i[create destroy]
    resources :channels, only: :show
    resources :messages, only: :create
  end
end
