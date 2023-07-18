Rails.application.routes.draw do
  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/confirm' => 'customers#confirm'
    patch 'customers/leave' => 'customers#leave'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  namespace :admin do
    root :to =>  'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_items, only: [:update]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
