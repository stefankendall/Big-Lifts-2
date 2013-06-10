require 'cucumber'
require 'cucumber/rake/task'

desc 'Run the tests'

task :test => [:unit]

task :unit do
  passed = system('xctool clean -workspace Big\ Lifts\ 2.xcworkspace -scheme Big\ Lifts\ 2Tests build test')
  fail 'Unit tests failed' unless passed
end

task :frank do
  passed = system('frank build --workspace "Big Lifts 2.xcworkspace" --scheme "Frank"')
  fail 'Frank failed' unless passed
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "Frank/features --format pretty"
end

task :functional => [:frank, :features]

task :default => :test
