# Load the Rails application.
require_relative 'application'
require 'simplecov-shield'

Rails.logger = Logger.new(STDOUT)
SimpleCov.formatter = SimpleCov::Formatter::ShieldFormatter

# Initialize the Rails application.
Rails.application.initialize!
