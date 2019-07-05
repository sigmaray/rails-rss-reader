Rails.application.routes.draw do
  get 'home/index'
  get 'home/feeds'
  root to: 'home#index'
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
