Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    resources :incentives
    get "get_code", to: 'incentives#get_code'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get :redeem, to: 'candidates#show'
  get :setup, to: 'researchers#show'
  root to: 'home#index'
end
