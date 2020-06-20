Rails.application.routes.draw do

  root to: 'cocktails#index'

  # *** cocktail routes
  # get 'cocktails', to: 'cocktails#index', as: :cocktails
  # get 'cocktails/new', to: 'cocktails#new', as: :new_cocktail
  # get 'cocktails/:id', to: 'cocktails#show', as: :cocktail
  # post 'cocktails', to: 'cocktails#create'

  resources :cocktails, only: %i[index show new create] do
    resources :doses, only: %i[new create]
  end

  # *** doses routes
  # get 'doses/new'
  # get 'doses/create'
  # get 'doses/edit'
  # get 'doses/update'
  # delete 'doses/:id', to: 'doses#destroy', as: :destroy_dose
  resources :doses, only: [:destroy]
end
