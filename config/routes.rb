Rails.application.routes.draw do

  resources :pokemon, only: [:show]

end
