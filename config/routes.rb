Rails.application.routes.draw do
  mount Pippin::App.new => '/pippin/ipns'
end
