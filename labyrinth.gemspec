# frozen_string_literal: true

require File.expand_path('lib/subparry_labyrinth_solver/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                   = 'subparry_labyrinth_solver'
  spec.version                = LabyrinthSolver::VERSION
  spec.authors                = ['Adrian Parry']
  spec.email                  = ['subparry@gmail.com']
  spec.summary                = 'An exercise for gem creation based on solving a labyrinth'
  spec.description            = 'This gem allows to find path for exiting a labyrinth'
  spec.homepage               = 'https://github.com/subparry/subparry-labyrinth-solver'
  spec.license                = 'MIT'
  spec.platform               = Gem::Platform::RUBY
  spec.required_ruby_version  = '>= 2.7.1'

  spec.files                  = Dir[
                                  'README.md',
                                  'LICENSE',
                                  'CHANGELOG.md',
                                  'Gemfile',
                                  'Rakefile',
                                  'lib/**/*.rb',
                                  'labyrinth.gemspec'
                                ]
  spec.extra_rdoc_files = ['README.md']

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.8'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.1'
  spec.add_development_dependency 'simplecov', '~> 0.16'
end
