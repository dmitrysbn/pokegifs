Rails.application.routes.draw do

  resources :pokemon, only: [:show]
  get '/team', to: 'pokemon#team'

end
