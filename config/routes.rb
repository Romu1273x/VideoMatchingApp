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
 post "users/:id/update" => "users#update"
 get "users/:id" => "users#show"

 # Post
 get 'posts/new'
 post "posts/create" => "posts#create"
 get "posts/:id/edit" => "posts#edit"
 post "posts/:id/update" => "posts#update"
 post "posts/:id/destroy" => "posts#destroy"
 get 'posts/index'
 get "posts/:id" => "posts#show"
  
end
