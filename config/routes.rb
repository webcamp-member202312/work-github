Rails.application.routes.draw do
  devise_for :controllers
  devise_for :users

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"
  get 'about' => 'public/homes#about'

  scope module: 'public' do
    resources :items, only: [:index, :show]
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
  end

  namespace :admin do
    resources :items, only: [:new, :show, :index, :create, :edit, :update]
    
    resources :genres, only: [:edit, :update]
    get "genres" => "genres#index"
    post "genres" => "genres#create"
    
    get "/" => "homes#top"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
