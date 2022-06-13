# frozen_string_literal: true

module AuthTestHelpers
  EMAIL = 'default@user.com'
  PASSWORD = '123123'

  def bearer_token
    auth_user
    Users::GenerateAuthToken.perform(email: EMAIL, password: PASSWORD).result[:token]
  end

  def auth_user
    @auth_user ||= create(:user, email: EMAIL, password: PASSWORD)
  end
end

RSpec.configure do |config|
  config.include AuthTestHelpers, type: :auth
end
