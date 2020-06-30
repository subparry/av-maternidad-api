Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'posts', to: 'posts#index'
  post 'posts', to: 'posts#create'
  post 'sign_in', to: 'sessions#create'
  get 'post/:id', to: 'posts#show'
  get 'recent_posts', to: 'recent_posts#index'
end
