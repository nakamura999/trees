Rails.application.routes.draw do

devise_for :admins, controllers: { sessions: 'admins/sessions' }

devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}

  namespace :admins do
     resources :users, only: [:show, :index, :destroy]
     resources :jenres, only: [:index, :edit, :create, :update]
     resources :top_admin, only: [:index]
  end

  root 'homes#top'
  get 'homes/top'

  get 'users/passwords/:id', to:"users#passwords", as: :passwords
  patch '/users/passwords/:id' ,to: "users#pass_update"
  put   '/users/passwords/:id' ,to: "users#pass_update"
  get 'users/withdraw/:id' => 'users#withdraw', as: :withdraw
  resources :users, only: [:show, :edit, :update, :destroy] do
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end

  resources :styles, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end

  resources :boards, only: [:show, :index, :create, :destroy] do
    resource :board_comments, only: [:create, :destroy]
  end

  resources :chats, only: [:create]
  resources :rooms, only: [:create, :show]

  resources :salons, only: [:create, :destroy, :new, :edit, :update]

  resources :contacts, only: [:create]

  get 'tags/:tag', to: 'styles#index', as: :tag

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
