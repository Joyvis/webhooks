# frozen_string_literal: true

module Users
  # service that creates a valid json web token used to autheticate in any
  # endpoint of the project
  class GenerateAuthToken
    include Services

    attr_reader :email, :password, :expires_in

    SECRET_KEY = Rails.application.secret_key_base

    def self.perform(email:, password:, expires_in: 2.days.from_now)
      new(email, password, expires_in).perform
    end

    def initialize(email, password, expires_in)
      @email = email
      @password = password
      @expires_in = expires_in
    end

    def perform
      if user&.authenticate(password)
        respond_success(token: generate_token)
      else
        respond_fail(error: 'Invalid Credentials')
      end
    end

    private

    def user
      @user ||= User.find_by(email: email)
    end

    def generate_token
      JWT.encode(payload, SECRET_KEY)
    end

    def payload
      {
        user_id: user.id,
        exp: expires_in.to_i
      }
    end
  end
end
