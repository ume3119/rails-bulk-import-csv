Rails.application.routes.draw do

  get 'employees/upload_csv' => 'employees#upload_csv', as: :upload_csv
  post 'employees/bulk_import' => 'employees#bulk_import', as: :bulk_import

  resources :policies
  resources :companies
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
