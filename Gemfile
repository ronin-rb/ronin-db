source 'https://rubygems.org'

RONIN_URI  = 'https://github.com/ronin-rb'

gemspec

gem 'jruby-openssl',	'~> 0.7', platforms: :jruby

# Library dependencies
gem 'ronin-support',	'~> 1.0', git: "#{RONIN_URI}/ronin-support.git",
                                branch: '1.0.0'

group :development do
  gem 'rake'
  gem 'rubygems-tasks',  '~> 0.1'
  gem 'rspec',           '~> 3.0'
  gem 'simplecov',       '~> 0.20'

  gem 'kramdown',        '~> 2.0'
  gem 'kramdown-man',    '~> 0.1'

  gem 'yard',            '~> 0.9'
  gem 'yard-spellcheck', require: false

  gem 'ruby-graphviz',   '~> 0.9.10'
  gem 'dm-visualizer',   '~> 0.2.0'

  gem 'dead_end',        require: false
end
