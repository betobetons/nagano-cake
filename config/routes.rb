Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :orders, only: [:show]
    resources :customers, only: [:show, :index, :edit]
    resources :categories, only: [:index, :edit]
    resources :items, only:[:index, :new, :show, :edit]
    get "/" => "homes#top"
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about', to:'homes#about', as:'about'
    resources :items, only: [:index, :show]
    resources :addresses, only: [:index, :edit]
    resources :carts, only: [:index]
    resources :orders, only:[:index, :show, :new] do
      collection do
        get 'confirm'
        get 'complete'
      end
    end
    get "customers/unsubscribe" => "customers#unsubscribe"
    get "customers/information/edit" => "customers#edit"
    get "customers/my_page" => "customers#show"
  end
end
