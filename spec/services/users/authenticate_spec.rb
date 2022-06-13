# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Authenticate, type: %i[service auth] do
  describe 'validating json web tokens' do
    subject(:auth) { described_class.perform(bearer_token: bearer_token) }

    context 'with a valid token' do
      it 'authorizes the current user' do
        expect(auth).to be_success
      end
    end

    context 'with a invalid token' do
      let(:bearer_token) { 'invalid_token' }

      it 'does not authorize the current user' do
        expect(auth).not_to be_success
      end
    end
  end
end
