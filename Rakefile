# frozen_string_literal: true

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

Dir.glob("./lib/tasks/**/*_task.rake").each { |task| load task }

require "bundler/gem_tasks"
require "rspec/core/rake_task"

require "archangel/testing_support/rake/dummy_rake"

RSpec::Core::RakeTask.new

task default: :spec

desc "Remove any generated files and directories"
task :clean do
  %w[
    brakeman.html Gemfile.lock spec/examples.txt yarn.lock
  ].each { |file| rm_f file }

  %w[
    .yardoc coverage doc pkg archangel_* node_modules pkg spec/dummy
  ].each { |directory| rm_rf directory }
end

desc "Generates a dummy app for Archangel"
task :dummy_app do
  ENV["LIB_NAME"] = "archangel"

  Rake::Task["dummy:generate"].invoke
end

desc "Run RSpec tests"
task test: :spec
