# frozen_string_literal: true

begin
  require 'bundler'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler"
  exit(-1)
end

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'rubygems/tasks'
Gem::Tasks.new(sign: {checksum: true, pgp: true})

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :test    => :spec
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new

desc "Generates all documentation"
task :docs => :yara

require 'kramdown/man/task'
Kramdown::Man::Task.new

directory 'db'
file 'db/dev.sqlite3' => %w[db db:migrate]

require 'ronin/db/tasks'
Ronin::DB::Tasks.new(database: {adapter: 'sqlite3', database: 'db/dev.sqlite3'})
file 'db/dev.sqlite3' => 'db:migrate'
task 'db:console' => 'db/dev.sqlite3'

require 'command_kit/completion/task'
CommandKit::Completion::Task.new(
  class_file:  'ronin/db/cli',
  class_name:  'Ronin::DB::CLI',
  output_file: 'data/completions/ronin-db'
)
