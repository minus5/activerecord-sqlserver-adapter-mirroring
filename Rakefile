require 'rake'
require 'rake/testtask'

# Notes for cross compile:
# $ gcla ; bundle install ; rake compile ; rake cross compile ; rake cross native gem

# Since the Gemfile for this project requires, rails, it ends up causing
# Rails.env to be defined, which affects some of the unit tests. We fix this
# by setting the RAILS_ENV to "default_env"
ENV['RAILS_ENV'] = 'default_env'

task :default => :test

desc 'Run tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/test_*.rb'
  t.verbose = true
end
