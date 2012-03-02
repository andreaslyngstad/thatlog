ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require 'minitest/spec'
require 'minitest/autorun'

require "active_support/testing/setup_and_teardown"
Turn.config.format = :outline
