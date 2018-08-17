Rails.application.routes.draw do

  get 'integrations/googlesheetsimport'

  get 'integrations/index'

  get 'integrations/googlesheets'

  post 'integrations/specificsheetimport'

  get 'internal/control'

  root 'front#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
