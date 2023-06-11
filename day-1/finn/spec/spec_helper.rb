require "simplecov"

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start do
  coverage_dir 'tmp/coverage'
  enable_coverage :branch
end

Dir["./spec/support/**/*.rb"].each { |f| require f }