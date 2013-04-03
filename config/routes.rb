Lodoss::Application.routes.draw do

  get "pages/index"

  get "pages/contact"

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  #defaul router
  root :to => 'sessions#new'

  get "sessions/new"

  resources :users
  match '/signup',  :to => 'users#new'
  match '/edit', :to => 'users#update'
  match '/users/friends/:id', :to => 'users#friends'
  match '/users/search/:search', :to => 'users#search'
  match '/users/:pending/:id', :to => 'users#friends'
  match '/users/actionFriend'


  resources :sessions, :only => [:new, :create, :destroy]
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/forgotpassword', :to => 'sessions#forgot_password'
  match '/newpassword/:hashlink', :to => 'sessions#new_password'
  match '/changepassword', :to => 'sessions#change_password'

  resources :comments
  match '/comments/side/:id', :to => 'comments#index'

  resources :messages
  match '/messages/chat/:id', :to => 'messages#chat'

end
