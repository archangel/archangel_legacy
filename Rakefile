# frozen_string_literal: true

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

Bundler::GemHelper.install_tasks

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

load "rails/tasks/engine.rake"
load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

task default: :spec

desc "(Re)Create test database and run tests"
task :test do
  Rake::Task["app:db:reset"].invoke
  Rake::Task["app:db:migrate"].invoke
  Rake::Task["spec"].invoke
end
