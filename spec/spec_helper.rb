require 'rubygems'
require 'bundler'
require 'rails'

Bundler.require :default, :development

Combustion.initialize! :action_controller

require 'rspec/rails'
require 'fakeweb_matcher'
