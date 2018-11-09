Rails.application.routes.draw do
  resources :students
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
	
	root 'welcome#home'
end
