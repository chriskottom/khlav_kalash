ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest/mock'

shared_files = Rails.root.join('test/shared/*.rb')
Dir.glob(shared_files) { |file| require file }

class ActiveSupport::TestCase
  AUTH_USERNAME = Rails.application.credentials.admin[:username]
  AUTH_PASSWORD = Rails.application.credentials.admin[:password]

  fixtures :all
end
