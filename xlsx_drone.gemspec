Gem::Specification.new do |s|
  s.name = "xlsx_drone"
  s.version = "0.2.0"
  s.summary = "XLSX reader/writer. So far, functionality for reading is provided."
  s.author = "Damián M. González"
  s.homepage = "http://www.jorobuslab.net"
  s.license = "Nonstandard"
  s.files = Dir["bin/*.rb"] + Dir["ext/*.dll"] + Dir["lib/**/*.rb"]

  s.required_ruby_version = ['~> 2', '< 2.6']
  s.add_runtime_dependency 'ffi', '~>1.0'
end