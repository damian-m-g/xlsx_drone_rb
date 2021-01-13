# necessary for yardoc task
require 'yard'

#################TASKS#######################

# generate yard documentation
YARD::Rake::YardocTask.new {|t|}

desc 'run tests'
task :test do
  require_relative './test/ts_general'
end

desc 'build gem'
task :build do
  puts('Building gem...')
  system('gem build xlsx_drone.gemspec')
  # move all gems in root dir to releases folder
  puts('Moving gem(s)...')
  require 'fileutils'
  Dir["./*.gem"].each do |gem|
    FileUtils.move(gem, "./releases/#{File.basename(gem)}", force: true)
  end
  puts('Gem(s) moved.')
end

desc 'run bechmark'
task :bm do
  load('test/benchmark/speed.rb')
end

# you will execute this before every new version release
desc 'perform measures & produce badges metadata'
task :badges do
  # TODO: Should parse coverage/index.html and produce coverage data only with lib/**/*.rb files, hardcoding value for now
  # TODO: Should parse all assertions and produce sum of all of them, hardcoding value for now
  # TODO: Should produce test suite pass badge only if all test passes, hardcoding value for now
end
