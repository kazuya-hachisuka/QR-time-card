Rails.application.routes.draw do
  devise_for :admins,controllers: {
  	sessions: 'admins/sessions',
  	registrations: 'admins/registrations'
  }
  resources :staffs, only:[:create,:new,:show,:update,:destroy] do
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
