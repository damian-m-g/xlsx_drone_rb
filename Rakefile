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
  system('gem build xlsx_drone.gemspec')
end
