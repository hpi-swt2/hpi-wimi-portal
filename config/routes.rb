Rails.application.routes.draw do

  get 'documents/generate_pdf' => 'documents#generate_pdf', :as => 'generate_pdf'

  root 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  get 'users/edit_leave', to: 'users#edit_leave'

  resources :publications
  resources :projects
  resources :holidays
  resources :trips
  resources :expenses

  devise_for :users

  resources :users, :only => [:show, :edit, :edit_leave, :update]

end
