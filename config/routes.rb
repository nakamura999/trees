Rails.application.routes.draw do

devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}

  namespace :admins do
     resources :users, only: [:show, :index]
     resources :jenres, only: [:index, :edit, :create, :update]
  end

  root 'homes#top'
  get 'homes/top'

  get 'users/withdraw/:id' => 'users#withdraw', as: :withdraw
  resources :users, only: [:show, :edit, :update, :destroy]

  resources :styles, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  resources :boards, only: [:show, :index, :create]

  resources :board_comments, only: [:create, :destroy]

  resources :favorites, only: [:create, :destroy]

  resources :rooms, only: [:create, :show]

  resources :board_comments, only: [:create]

  resources :salons, only: [:create, :destroy, :new, :edit, :update]

  resources :contacts, only: [:create]

  get 'tags/:tag', to: 'styles#index', as: :tag

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
