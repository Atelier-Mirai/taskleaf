Rails.application.routes.draw do
  root to: 'welcome#index'

  namespace :admin do
    resources :users
  end

  resources :tasks do
    post :import, on: :collection
  end

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get    '/signup', to: 'users#new'

  # error 表示
  # match '*path' => 'application#error404', via: :all if Rails.env.production?
  get '404', to: 'errors#not_found'

  # letter opener web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
