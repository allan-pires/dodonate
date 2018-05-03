require 'simplecov'
require 'simplecov-shield'

SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'

require_relative '../config/environment'