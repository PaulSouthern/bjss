# frozen_string_literal: true

# All files for Configurations & reporting
require 'selenium-webdriver'
require 'pry'
require 'rspec'

# app
require_relative '../helpers/helpers'

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
#
RSpec.configure do |config|
  config.before(:each) do
    @driver = Selenium::WebDriver.for :firefox
  end

  config.after(:each) do
    @driver.quit
  end

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.color = true
  config.run_all_when_everything_filtered = false
  config.order = :defined # run specs top down
  config.fail_fast = false
  config.example_status_persistence_file_path = 'tmp/rspec_failures/failed_examples.txt'

  yield config if block_given?
end

# Setting up allure for reporting
RSpec.configure do |config|
  config.include AllureRSpec::Adaptor
  config.after(:each) do |example|
    if example.exception
      example.attach_file(
        'screenshot', File.new(@browser.save_screenshot(file: 'tmp/allure_' + build_path + "/#{UUID.new.generate}.png"))
      )
    end
  end
end

AllureRSpec.configure do |config|
  config.output_dir = 'tmp/allure_' + build_path
  config.clean_dir = false # this is the default value
  config.logging_level = Logger::ERROR # logging level (default: DEBUG)
end

ParallelTests.first_process? ? FileUtils.rm_rf(AllureRSpec::Config.output_dir) : sleep(1)

# Method to check if directory exists
def directory_exists?(directory)
  File.directory?(directory)
end