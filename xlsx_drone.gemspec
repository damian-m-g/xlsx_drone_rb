Gem::Specification.new do |s|
  s.name = "xlsx_drone"
  s.version = "0.4.2"
  s.summary = "Fast Microsoft Excel's XLSX reader. Binding of C's xlsx_drone lib."
  s.author = "Damián M. González"
  s.homepage = "https://github.com/damian-m-g/xlsx_drone_rb"
  s.license = "MIT"
  s.files = Dir["bin/*.rb"] + Dir["ext/*.dll"] + Dir["lib/**/*.rb"]

  s.required_ruby_version = '> 2'
  s.add_runtime_dependency 'ffi', '~>1.0'
end