Rails.application.routes.draw do
  
 # Home
 get '/' => "home#top"

 # User
 get "signup" => "users#new"
 post "users/create" => "users#create"
 get "login" => "users#login_form"
 post "login" => "users#login"
 post "logout" => "users#logout"
 get "users/index" => "users#index"
 get "users/:id/edit" => "users#edit"
 patch "users/:id/update" => "users#update"
 get "users/:id" => "users#show"
 get "users/:id/likes" => "users#likes"

 # Post
 resources :posts

 # Room
 resources :rooms, only: [:index, :create, :show]

 # Message
 resources :messages, only: [:create, :destroy]
  
 # Like
 resources :likes, only: [:create, :destroy]

end
