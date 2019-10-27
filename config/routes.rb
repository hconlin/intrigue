Rails.application.routes.draw do

  get 'slides/create'
  get 'slides/destroy'
  get 'slides/new'
  get 'images/new'
  get 'images/create'
  get 'images/destroy'
  root 'home#index'

  resources :users
  resources :sessions, only:[:new, :create, :destroy]
  resources :images, only:[:new, :create, :destroy]
  resources :slides, only:[:new, :create, :destroy]
  resources :contacts, only:[:new, :create]

  #sessions
  get '/admin', to: 'sessions#new', as: 'admin'
  get '/logout', to: 'sessions#destroy', as: 'session_destroy'

  #images
  get '/admin/images/new', to: 'images#new', as: 'upload_image'
  get '/images/delete/:id', to: 'images#destroy', as: 'destroy_image'

  #slides
  post '/admin/slides/set/:image_id', to: 'slides#create', as: 'set_slide'
  post '/slides/delete/:id', to: 'slides#destroy', as: 'destroy_slide'

  #home
  get '/panel', to: 'home#admin', as: 'admin_panel'
  post '/cover/new/:id', to: 'home#cover', as: 'set_cover'
  post '/cover/delete/:id', to: 'home#delete_cover', as: 'destroy_cover'

  #mailer
  post '/contacts/new', to: 'contacts#new', as: 'send_email'

  #gallery
  get '/gallery', to: 'home#gallery', as: 'gallery'
end
