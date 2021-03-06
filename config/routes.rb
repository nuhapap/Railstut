Railstut::Application.routes.draw do
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  get "sessions/new"

  #restes akciok
  resources :users
  resources :sessions,      :only => [:new, :create, :destroy]
  resources :microposts,    :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]



  get "users/new"

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  
  #csak egy ket cucc amit beleirtam
  match '/printout',:to => 'pages#printout'

  root :to => 'pages#home'
  

end
