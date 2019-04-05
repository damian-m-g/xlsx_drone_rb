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
