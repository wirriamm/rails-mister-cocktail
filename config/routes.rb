Rails.application.routes.draw do
  root to: 'cocktails#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cocktails, only: [:index, :show, :new, :create] do
    # Don't need doses#index as doses can be listed in #cocktail#show
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]
end
