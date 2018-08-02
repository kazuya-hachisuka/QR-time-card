Rails.application.routes.draw do
  devise_for :admins, controllers: {
	sessions:      'admins/sessions',
  passwords:     'admins/passwords',
	registrations: 'admins/registrations'
  }

  resources :admins

  root'cameras#scan'

  resources :stores,only:[:index,:show,:new,:create,:update,:destroy]

  resources :staffs, only:[:index,:create,:new,:show,:update] do

    resources :works,only:[:create,:new,:update,:index,:edit,:destroy]

    get 'works/add_work' => 'works#add_work', as:'work_add'

    post 'works/add_work_create' => 'works#add_work_create', as:'work_add_create'

    post 'works/:work_id/breaks' => 'works#break_create', as:'work_break_in'

    patch 'works/:work_id/breaks' => 'works#break_update', as:'work_break_out'

    delete 'work/:work_id/breaks' => 'works#break_destroy', as: 'work_breaks'

    patch 'work_edit/:work_id/' => 'works#shift_out', as:'shift_out'

  end

  get 'staffs/:staff_id/works/show' => 'works#show'

  get 'cameras/scan_mobile' => 'cameras#scan_mobile', as:'camera_mobile'#instascan PC用

  get 'cameras/scan' => 'cameras#scan', as:'camera' #jsQR モバイル用

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
