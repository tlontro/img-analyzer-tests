Bundler.require
require 'capybara/dsl'
require 'active_support/core_ext/integer/inflections'
require 'fileutils'

require_relative '../lib/config'
require_relative '../pages/page_objects'
require_relative 'capybara_drivers'
require_relative 'docker_helpers'

include Configuration

$project_base_path = File.dirname(__FILE__).split('features/support').first

capybara_driver = ENV.fetch('DRIVER', 'local')
capybara_browser = ENV.fetch('BROWSER', 'chrome')
CapybaraDrivers.set_driver("#{capybara_driver}_#{capybara_browser}".to_sym)

World(Capybara::DSL)
