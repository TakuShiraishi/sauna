Rails.application.routes.draw do
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"

  scope module: :public do
    resources :saunas, only: [:new,:index,:show,:edit,:create,:destroy,:update ] do
      get :show_index_sauna
      resources :comments, only: [:create, :destroy,:index,:new] do
        resource :comment_favorites, only: [:create, :destroy]
      end
      resource :favorites, only: [:create, :destroy]
    end
    resources :users, only: [:new,:index,:show,:edit,:update,:create] do
      get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      patch '/users/withdraw' => 'users#withdraw', as: 'withdraw'
      get "search", to: "users#search"
      resource :favorites, only: [:create, :destroy]
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
       member do
      get :favorites
     end
    end
    resource :searchs, only: [:index] do
      get :search_sauna_result
      get :search_user_result
    end
  end
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # 顧客用
  # URL /users/sign_in ...
   namespace :admin do
    get '/'  => "homes#top", as: "/"
    resources :saunas do
    get :show_index_sauna
    resources :comments, only: [:destroy,:index,]
    end
    resources :users do
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdraw' => 'users#withdraw', as: 'withdraw'
   end
 end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
