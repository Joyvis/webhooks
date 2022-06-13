# frozen_string_literal: true

module Users
  # service that validates a given json web token and authenticate a user
  # based on the token
  class Authenticate
    include Services

    attr_reader :bearer_token

    SECRET_KEY = Rails.application.secret_key_base

    def self.perform(bearer_token:)
      new(bearer_token).perform
    end

    def initialize(bearer_token)
      @bearer_token = bearer_token&.split('Bearer ')&.last
    end

    def perform
      return respond_fail(error: 'Unauthorized') if token_decoded.blank?

      respond_success(user: user)
    end

    private

    def token_decoded
      @token_decoded ||= begin
        HashWithIndifferentAccess.new(
          JWT.decode(bearer_token, SECRET_KEY).first
        )
      rescue StandardError
        nil
      end
    end

    def user
      User.find(token_decoded[:user_id])
    end
  end
end
