module HttpBasicAuthenticatable
  extend ActiveSupport::Concern

  def http_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.admin[:username] &&
        password == Rails.application.credentials.admin[:password]
    end
  end
end