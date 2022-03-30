source 'https://rubygems.org'

RONIN_URI  = 'https://github.com/ronin-rb'

gemspec

gem 'jruby-openssl',	'~> 0.7', platforms: :jruby
gem 'sqlite3',        '~> 1.4'

# Library dependencies
gem 'ronin-db-activerecord', '~> 0.1', git: "#{RONIN_URI}/ronin-db-activerecord.git",
                                       branch: 'main'

gem 'ronin-support',	'~> 1.0', git: "#{RONIN_URI}/ronin-support.git",
                                branch: '1.0.0'

gem 'ronin-core',	'~> 0.1', git: "#{RONIN_URI}/ronin-core.git",
                            branch: 'main'

group :development do
  gem 'rake'
  gem 'rubygems-tasks',  '~> 0.1'
  gem 'rspec',           '~> 3.0'
  gem 'simplecov',       '~> 0.20'

  gem 'kramdown',        '~> 2.0'
  gem 'kramdown-man',    '~> 0.1'

  gem 'redcarpet',       platform: :mri
  gem 'yard',            '~> 0.9'
  gem 'yard-spellcheck', require: false

  gem 'dead_end',        require: false
end
