Rails.application.routes.draw do
  class Subdomain
    def self.matches?(request)
      request.subdomain.present? && request.subdomain != 'www'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  constraints Subdomain do
    devise_for :users
    root 'recurring_events#show'
    resources :participations, only: %i[create destroy]
    resources :channels, only: :show
    resources :messages, only: :create
  end
end
