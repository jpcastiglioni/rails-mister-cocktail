Rails.application.routes.draw do
  # get 'cocktails/index'
  root to: 'cocktails#index'
  get 'cocktails/new', to: 'cocktails#new', as: :new_cocktail
  get 'cocktails/:id', to: 'cocktails#show', as: :cocktail
  post 'cocktails', to: 'cocktails#create'
end
