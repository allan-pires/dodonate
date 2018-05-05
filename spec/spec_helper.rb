require 'simplecov'
require 'simplecov-shield'

SimpleCov.start
#SimpleCov.formatter = SimpleCov::Formatter::ShieldFormatter

ENV["RAILS_ENV"] ||= 'test'

require_relative '../config/environment'