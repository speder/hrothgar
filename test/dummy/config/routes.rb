Rails.application.routes.draw do
  resources :jobs, :only => [:index, :create]
  root :to => 'jobs#index'
  mount Hrothgar::Engine => "/hrothgar"
end
