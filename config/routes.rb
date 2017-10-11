require 'api_version_constraint'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # API
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
  	
  	# Version 1
  	namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
  		resources :posts, only: [:index, :show, :create, :update, :destroy] do
  			resources :comments, only: [:index, :show, :create, :update, :destroy]
  		end
  	end

  end
  
end