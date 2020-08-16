require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include StripeElements

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def visit_with_basic_auth(location, username:, password:)
    uri = URI.parse(location)
    uri.user = username
    uri.password = password
    visit uri
  end
end
