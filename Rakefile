require 'cucumber'
require 'cucumber/rake/task'

desc 'Run the tests'

task :test => [:unit, :functional]

task :unit do
  system('xctool -project Big\ Lifts\ 2.xcodeproj -scheme Big\ Lifts\ 2Tests test')
end

task :frank do
  system('frank build')
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "Frank/features --format pretty"
end

task :functional => [:frank, :features]

task :default => :test
