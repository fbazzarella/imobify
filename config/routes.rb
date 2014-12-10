NewApp::Application.routes.draw do
  root to: 'admin/realties#index'

  namespace :admin do
    devise_for :users, controllers: {sessions: 'admin/sessions'}

    root to: 'realties#index'

    resources :realties, only: [:index, :new]
  end
end
