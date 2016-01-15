Rails.application.routes.draw do
  resources :chair_applications
  resources :chairs

  resources :project_applications, only: [:index, :destroy] do
    member do
      get 'accept'
      get 'decline'
      get 'reapply'
    end
    collection do
      post 'apply/project_:id', to: 'project_applications#create', as: 'apply'
    end
  end

  get 'documents/generate_pdf' => 'documents#generate_pdf', as: 'generate_pdf'

  root 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  get 'users/edit_leave', to: 'users#edit_leave'

  resources :publications
  resources :projects do
    member do
      post 'invite_user'
      get 'accept_invitation'
      get 'decline_invitation'
    end
  end

  resources :projects do
    member do
      get 'toggle_status'
      delete 'sign_user_out/:user_id', action: 'sign_user_out', as: 'sign_user_out'
    end
  end

  get 'projects/typeahead/:query' => 'projects#typeahead'

  resources :holidays
  resources :expenses
  resources :work_days
  resources :time_sheets, only: [:edit, :update, :delete, :reject, :hand_in, :accept] do
    member do
      get 'reject'
      get 'hand_in'
      get 'accept'
    end
    get 'time_sheets/reject', to: 'time_sheets#reject'
    get 'time_sheets/hand_in', to:'time_sheets#hand_in'
    get 'time_sheets/accept', to:'time_sheets#accept'
  end

  resources :travel_expense_reports
  resources :trips do
    member do
      get 'download'
    end
  end

  resources :chairs

  post 'chairs/apply', to: 'chairs#apply'
  post 'chairs/accept', to: 'chairs#accept_request'
  post 'chairs/remove_user', to: 'chairs#remove_from_chair'
  post 'chairs/destroy', to: 'chairs#destroy'
  post 'chairs/set_admin', to: 'chairs#set_admin'
  post 'chairs/withdraw_admin', to: 'chairs#withdraw_admin'
  get 'chairs/:id/requests' => 'chairs#requests', as: 'requests'

  devise_for :users

  resources :users, only: [:show, :edit, :edit_leave, :update]
  
end

