Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do 
      namespace :merchants do 
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
      end 
      resources :merchants, only: [:index, :show] do  
        resources :items, only: [:index]
        resources :invoices, only: [:index]

        get :revenue, on: :collection
      end 

      namespace :customers do 
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
      end 
 
      resources :customers, only: [:index, :show]
      
      namespace :items do
        get '/find', to: "search#show" 
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
      end 

      resources :items, only: [:index, :show]

      namespace :transactions do 
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
      end 

      resources :transactions, only: [:index, :show]

      namespace :invoices do 
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
      end 

      resources :invoices, only: [:index, :show] do 
        resources :merchants, only: [:index]
        resources :customers, only: [:index]
        resources :transactions, only: [:index], controller: 'invoices/transactions'
        resources :items, only: [:index]
        resources :invoice_items, only: [:index]
      end 

      namespace :invoice_items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index" 
        get '/random', to: "random#show"
      end 

      resources :invoice_items, only: [:index, :show]
    end 
  end 
end 