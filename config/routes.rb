SessionsTemplate::Application.routes.draw do
  
  resources :bills, :except => :destroy

  resource :dashboard, :only => :dashboard

  resources :debts, :only => [:create, :new, :show]
  
  resources :friends, :only => :show
  
  resources :friendships, :only => :create
  
  resource :session, :only => [:new, :create, :destroy]
  
  resources :users, :only => [:new, :create, :show]

  root :to => "dashboard#dashboard"
end
