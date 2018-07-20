Rails.application.routes.draw do
  devise_for :admins,controllers: {
  	sessions: 'admins/sessions',
  	registrations: 'admins/registrations'
  }

  root'cameras#show'

  resources :stores,only:[:index,:show,:new,:create,:update,:destroy]

  resources :staffs, only:[:create,:new,:show,:update,:destroy] do
  end

  get 'cameras/show' => 'cameras#show' #instascan モバイル用

  get 'cameras/index' => 'cameras#index' #jsQR PC用

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
