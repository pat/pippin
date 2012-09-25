# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'pippin'
  s.version     = '1.0.0'
  s.authors     = ['Pat Allan']
  s.email       = ['pat@freelancing-gods.com']
  s.homepage    = ''
  s.summary     = 'A PayPal Rails Engine that handles IPNs'
  s.description = 'Accepts IPN requests, validates them and passes them on to a defined listener.'

  s.rubyforge_project = 'pippin'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'activesupport', '>= 3.1'

  s.add_development_dependency 'fakeweb',         '1.3.0'
  s.add_development_dependency 'fakeweb-matcher', '1.2.2'
  s.add_development_dependency 'rspec-rails',     '2.7.0'
  s.add_development_dependency 'sqlite3',         '1.3.5'
end
