require "rake/testtask"

Rake::TestTask.new(:testlib => "db:test:prepare") do |t|
  t.libs << "spec"
  t.pattern = "spec/lib/*_spec.rb"
end

