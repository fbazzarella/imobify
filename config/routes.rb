NewApp::Application.routes.draw do
  root to: 'admin/users#index'

  namespace :admin do
    devise_for :users, controllers: {sessions: 'admin/sessions'}

    root to: 'users#index'

    resources :users, only: :index
  end
end
