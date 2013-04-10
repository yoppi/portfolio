Portfolio::Application.routes.draw do
  root :to => 'home#index'
  resources :home, only: [:index]
  resources :activity, only: [:index] do
    collection do
      get 'test_double'
    end
  end
  resources :blog, only: [:index]
  resources :twitter, only: [:index]
  resources :github, only: [:index]
end
