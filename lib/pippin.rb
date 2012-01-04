require 'rails'

module Pippin
  def self.listener
    @listener
  end

  def self.listener=(listener)
    @listener = listener
  end
end

require 'pippin/engine'
require 'pippin/ipn'
require 'pippin/version'
