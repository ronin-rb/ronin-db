require 'rubygems'

begin
  require 'bundler'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler"
  exit -1
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

namespace :db do
  task :connect do
    require 'active_record'
    ActiveRecord::Base.establish_connection(
      adapter:  'sqlite3',
      database: 'db/dev.sqlite3'
    )
  end

  desc 'Migrates the development database'
  task :migrate => :connect do
    lib_dir = File.expand_path('lib')
    $LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

    require 'ronin/db/migrations'

    Ronin::DB::Migrations.up
  end

  desc 'Starts an interactive database console'
  task :console => 'db/dev.sqlite3' do
    require 'active_record'
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/dev.sqlite3'
    )

    require 'ronin/db/models'
    Ronin::DB::Models.connect

    require 'ronin/db/cli/console'
    Ronin::DB::CLI::Console.start
  end
end
