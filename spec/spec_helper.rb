require 'simplecov'
require 'simplecov-shield'

SimpleCov.start
SimpleCov.minimum_coverage 95
SimpleCov.formatter = SimpleCov::Formatter::ShieldFormatter

ENV["RAILS_ENV"] ||= 'test'

require_relative '../config/environment'