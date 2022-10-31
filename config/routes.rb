Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, format: :json do
    namespace :v1 do
      resources :users, only: [] do
        post :sign_in, on: :collection
      end

      resources :domains, only: %i[index]

      resources :assessments, only: %i[create update]
    end
  end
end
