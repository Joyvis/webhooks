# frozen_string_literal: true

# controller to manage authentication flow
class SessionsController < ApplicationController
  skip_before_action :authenticate_request

  def create
    generate_token = Users::GenerateAuthToken.perform(email: params[:email], password: params[:password])
    if generate_token.success?
      render json: { token: generate_token.result[:token] }, status: :created
    else
      unauthorized
    end
  end
end
