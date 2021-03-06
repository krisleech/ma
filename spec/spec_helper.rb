require "bundler/setup"
require "ma"

require 'pry' unless ENV['CI']

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.run_all_when_everything_filtered = true
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
