begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end

desc 'Run the tests'
task :test => [:unit]

task :unit do
  passed = system('xctool clean -workspace Big\ Lifts\ 2.xcworkspace -scheme Big\ Lifts\ 2Tests build test')
  fail 'Unit tests failed' unless passed
end

task :default => :test
