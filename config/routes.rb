Rails.application.routes.draw do
  root 'static_pages#home'
  get  'post_new',       to: 'posts#new',    as: 'p_new'
  post 'post_create',    to: 'posts#create', as: 'p_create'
  get  'post_index',     to: 'posts#index',  as: 'p_index'
  get  'post_show/:id',  to: 'posts#show',   as: 'p_show'
  get  'post_edit/:id',  to: 'posts#edit',   as: 'p_edit'
  patch  'post_update/:id',    to: 'posts#update',  as: 'p_up'
  delete 'post_delete/:id',    to: 'posts#destroy', as: 'p_des'
  post  'posts/:post_id/comment',    to: 'comments#create', as: 'p_com'
  post  'posts/:post_id/comment/:parent_id', to: 'comments#new', as: 'reply'
  resources :posts do
    resources :likes, only: [:create, :destroy]
    # resources :comments, only: [:create]
  end
  
  
  get  'user/new',       to: 'users#new',    as: 'u_new'
  post 'user/create',    to: 'users#create', as: 'u_create'
  get  'user/index',     to: 'users#index',  as: 'u_index'
  get  'user/show/:id',      to: 'users#show',   as: 'u_show'
  get  'user/edit',      to: 'users#edit',   as: 'u_edit'
  patch'user/update',    to: 'users#update', as: 'u_up'
  
  get    '/login',         to: 'sessions#new'
  post   '/login',         to: 'sessions#create'
  delete '/logout',        to: 'sessions#destroy'
  
  # get  '/user/:id/following',  to: 'users#following',  as: 'following_user_path'
  # get  '/user/:id/followers',  to: 'users#followers',  as: 'followers_user_path'
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  get 'messages/index/:id', to:  'messages#index', as: 'm_index'
  get 'messages/room/:user_id/:to_user_id' => "messages#roomshow"
  resources :messages
  
  resources :relationships,       only: [:create, :destroy]
end