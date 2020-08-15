ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  AUTH_USERNAME = "admin"
  AUTH_PASSWORD = "password"

  fixtures :all
end
