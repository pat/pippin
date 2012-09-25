require 'active_support/notifications'
require 'active_support/core_ext/module/delegation'

module Pippin
  #
end

require 'pippin/app'
require 'pippin/ipn'
require 'pippin/version'

require 'pippin/engine' if defined?(Rails)
