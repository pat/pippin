Rails.application.routes.draw do
  namespace :pippin do
    resources :ipns, :only => [:create]
  end
end
