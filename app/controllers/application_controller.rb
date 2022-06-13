# frozen_string_literal: true

# Base class for all controllers
class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  protect_from_forgery with: :null_session

  before_action :authenticate_request

  private

  def authenticate_request
    autheticate = Users::Authenticate.perform(bearer_token: bearer_token)
    return unauthorized unless autheticate.success?

    @current_user = autheticate.result[:user]
  end

  def not_found
    render json: { error: 'Not Found' }, status: :not_found
  end

  def unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def bearer_token
    request.headers['Authorization']
  end
end
