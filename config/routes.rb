NewApp::Application.routes.draw do
  root to: 'realties#index'

  resources :realties, only: [:index, :show]

  namespace :admin do
    devise_for :users, controllers: {sessions: 'admin/sessions'}

    root to: 'realties#index'

    resources :realties, only: [:index, :create, :edit, :update] do
      resources :photos, only: [:create, :destroy]

      put :publish
      put :deactivate
    end

    resources :countries, only: [] do
      resources :cities, only: :index
    end
  end
end
