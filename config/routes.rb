Rails.application.routes.draw do
  resources :meetings
  resources :locations

  resources :students do 
	resources :meetings 
  end
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
	
	root 'welcome#home'
end
