Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: %i[passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: %i[registrations passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :orders, only: %i[show]
    resources :customers, only: %i[show index edit]
    resources :categories, only: %i[index edit create update]
    resources :items, only: %i[index new show edit create update]
    get "/" => "homes#top"
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about', to:'homes#about', as:'about'
    resources :items, only: %i[index show]
    resources :addresses, only: %i[index edit create destroy update]
    resources :carts, only: %i[index]
    resources :orders, only: %i[index show new] do
      collection do
        get 'confirm'
        get 'complete'
      end
    end
    patch "customers/withdraw" => "customers#withdraw"
    get "customers/unsubscribe" => "customers#unsubscribe"
    get "customers/information/edit" => "customers#edit"
    get "customers/my_page" => "customers#show"
  end
end
