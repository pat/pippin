class Pippin::Engine < Rails::Engine
  paths['app/controllers'] << 'app/controllers'
  paths['config'] << 'config'
end
