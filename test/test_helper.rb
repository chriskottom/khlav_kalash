ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest/mock'

class ActiveSupport::TestCase
  AUTH_USERNAME = Rails.application.credentials.admin[:username]
  AUTH_PASSWORD = Rails.application.credentials.admin[:password]

  fixtures :all
end
