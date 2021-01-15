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
  require 'json'
  generate_coverage_badge()
  generate_assertions_badge()
  puts("\nRunning tests...\n\n")
  generate_test_suite_badge(pass: system('rake test'))
end

# @return [boolean]
# Should be called after a "run test with coverage" have been performed. Consumes coverage/.last_run.json.
def generate_coverage_badge
  # consume data
  covered = \
    File.open('coverage/.last_run.json') do |f|
      JSON.parse(f.read)['result']['line']
    end
  # inquire matching color according to the amount of code covered
  color = \
    case (covered)
      when (80..100)
        'brightgreen'
      when (60..80)
        'green'
      when (40..60)
        'yellowgreen'
      else
        'orange'
    end
  # produce the json string
  json = {
    'schemaVersion': 1,
    'label': 'coverage',
    'message': "#{covered}%",
    'color': color
  }.to_json
  # write the file
  File.open('data/shields/simplecov.json', 'w:utf-8:utf-8') {|f| f.write(json)}
rescue
  puts 'ERROR: Coverage badge failed to be created.'
  false
else
  puts "Coverage badge was successfully created: #{covered}%."
  true
end

# Counts assertions inside test suite.
def generate_assertions_badge
  assertions = 0
  Dir["./test/tc_*.rb"].each do |f|
    File.open(f) do |f|
      assertions += f.read.scan(/assert/).size
    end
  end
  # produce the json string
  json = {
    'schemaVersion': 1,
    'label': 'test assertions',
    'message': assertions.to_s,
    'color': 'informational'
  }.to_json
  # write the file
  File.open('data/shields/assertions.json', 'w:utf-8:utf-8') {|f| f.write(json)}
  # provide some output
  puts("Assertions badge was successfully created: #{assertions}.")
end

# @param pass [boolean]
def generate_test_suite_badge(pass:)
  # produce the json string
  require 'json'
  json = {
    'schemaVersion': 1,
    'label': 'test suite',
    'message': pass ? 'pass' : 'fail',
    'color': pass ? 'brightgreen' : 'red'
  }.to_json
  # write the file
  File.open('data/shields/test_suite.json', 'w:utf-8:utf-8') {|f| f.write(json)}
  # provide some output
  if(pass)
    # tests passed
    puts("\nTest suite badge was successfully created: pass.")
  else
    # tests failed
    puts("\nWARNING: Test suite badge was successfully created: fail.")
  end
end