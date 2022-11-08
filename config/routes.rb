Rails.application.routes.draw do
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"

  scope module: :public do
    resources :saunas, only: [:new,:index,:show,:edit,:create,:destroy,:update] do
      resources :comments, only: [:create, :destroy]
      resource  :favorites, only: [:create, :destroy]
    end
    resources :users, only: [:new,:index,:show,:edit,:update,:create] do
      get "search", to: "users#search"
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resource :searchs, only: [:index] do
      get :search_result
    end
  end

  # 顧客用
  # URL /users/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
