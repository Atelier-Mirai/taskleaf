Rails.application.routes.draw do
  root to: 'welcome#index'

  namespace :admin do
    resources :users
  end

  resources :tasks

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get    '/signup', to: 'users#new'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
