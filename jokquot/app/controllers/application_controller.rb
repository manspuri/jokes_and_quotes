class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  resources :posts, except: [:new, :edit]
  resources :comments, except: [:show, :index, :new, :edit]
  resources :user, except: [:index, :edit, :update, :delete]

  root '/' => 'posts#index'
end
