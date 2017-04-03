Rails.application.routes.draw do
  devise_for :users
  get 'users' => 'users#index'

  get 'extern' => 'users#external_login', as: 'external_login'

  resources :chair_applications
  resources :chairs do
  end
  post 'chairs/:id/users' => 'chairs#add_user', as: :chair_users
  delete 'chairs/:id/users/:request' => 'chairs#remove_user', as: :chair_user
  post 'chairs/:id/admins' => 'chairs#set_admin', as: :chair_admins
  delete 'chairs/:id/admins/:request' => 'chairs#withdraw_admin', as: :chair_admin
  
#  post 'chairs/remove_user', to: 'chairs#remove_from_chair'
#  post 'chairs/destroy', to: 'chairs#destroy'
#  post 'chairs/set_admin', to: 'chairs#set_admin'
#  post 'chairs/withdraw_admin', to: 'chairs#withdraw_admin'
  get 'chairs/:id/requests' => 'chairs#requests', as: 'requests'
  post 'chairs/:id/requests' => 'chairs#requests_filtered', as: 'requests_filtered'

  get 'documents/generate_pdf' => 'documents#generate_pdf', as: 'generate_pdf'

  # root 'dashboard#index'
  root :to => redirect('/dashboard')
  get 'dashboard', to: 'dashboard#index'
  get 'users/edit_leave', to: 'users#edit_leave'
  get 'users/language', to: 'users#language'

  resources :projects do
    member do
      post 'add_user'
    end
  end

  resources :projects do
    member do
      get 'toggle_status'
      delete 'remove/:user', action: 'remove_user', as: 'remove_user'
      post 'leave'
    end
  end

  #get 'projects/typeahead/:query', to: 'projects#typeahead', constraints: {query: /[^\/]+/}
  get 'projects/hiwi_working_hours/:month_year', to: 'projects#hiwi_working_hours'

  resources :holidays do
    member do
      get 'file'
      get 'accept_reject'
    end
    get 'holidays/file', to: 'holidays#file'
    get 'holidays/accept_reject', to: 'holidays#accept_reject'
  end

  resources :contracts do
    resources :time_sheets, only: [:new, :create]
    member do
      get 'dismiss'
    end
    post ':month/:year', to: 'time_sheets#create_for_month_year', as: 'create_for_month_year'
  end

  resources :time_sheets, except: [:new, :index] do
    member do
      get 'withdraw'
      patch 'hand_in'
      get 'accept_reject'
      get 'download'
    end
    collection do
      get 'current'
    end
  end

  resources :trips do
    resources :expenses, except: [:show, :index]
    member do
      get 'download'
      get 'file'
      get 'accept_reject'
    end
    get 'trips/file', to: 'trips#file'
    get 'trips/accept_reject', to: 'trips#accept_reject'
  end
  
  get 'projects/typeahead/:query' => 'projects#typeahead'

  post 'events/hide', to: 'events#hide', as: 'hide_event'
  post 'events/request', to: 'events#show_request', as: 'show_event_request'

  get 'projects/typeahead/:query' => 'projects#typeahead'

  # status 'saved' -> status 'applied'
  #post 'holidays/:id/file', to: 'holidays#file', as: 'file_holiday'
  #post 'holidays/:id/reject', to: 'holidays#reject', as: 'reject_holiday'
  #post 'holidays/:id/accept', to: 'holidays#accept', as: 'accept_holiday'
  post 'trips/:id/hand_in', to: 'trips#hand_in', as: 'hand_in_trip'
  post 'expenses/:id/hand_in', to: 'expenses#hand_in', as: 'hand_in_expense'

  post 'users/:id/upload_signature', to: 'users#upload_signature', as: 'upload_signature'
  post 'users/:id/delete_signature', to: 'users#delete_signature', as: 'delete_signature'

  resources :users, only: [:show, :edit, :edit_leave, :update]
  get '/users/autocomplete/:query', to: 'users#autocomplete', as: 'autocomplete'
end
