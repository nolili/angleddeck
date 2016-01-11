Rails.application.routes.draw do
  get 'builds/show'

  get 'builds/new'

  root "welcome#index"

  resources :projects, only: [:new, :create, :show] do
    resources :topics, only: [:show, :new, :create] do
      resources :builds, only: [:show, :new, :create] do
        get 'plist' => "builds#plist"
      end
    end

    post 'hooks/github' => 'projects/hooks#github'
  end

  namespace :api do
    resources :projects, only: [] do
      resources :builds, only: :create
    end
  end
end
