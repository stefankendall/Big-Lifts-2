require 'cucumber'
require 'cucumber/rake/task'

desc 'Run the tests'

task :test => [:unit, :functional]

task :unit do
  passed = system('xctool clean -project Big\ Lifts\ 2.xcodeproj -scheme Big\ Lifts\ 2Tests test')
  fail 'Unit tests failed' unless passed
end

task :frank do
  passed = system('frank build')
  fail 'Frank failed' unless passed
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "Frank/features --format pretty"
end

task :functional => [:frank, :features]

task :default => :test
