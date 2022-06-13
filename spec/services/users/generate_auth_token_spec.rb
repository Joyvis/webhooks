# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::GenerateAuthToken, type: :service do
  describe 'generating a json web token' do
    subject(:generate) { described_class.perform(email: email, password: user_password) }

    let(:password) { '123412' }
    let(:user) { create(:user, email: 'test@test.com', password: password) }

    context 'with valid credentials' do
      let(:email) { user.email }
      let(:user_password) { password }

      it 'generates a valid token' do
        expect(generate.result[:token]).to be_present
      end

      it 'returns a success response' do
        expect(generate).to be_success
      end
    end

    context 'with invalid credentials' do
      let(:email) { user.email }
      let(:user_password) { 'invalid_password' }

      it 'does not generate a valid token' do
        expect(generate.result[:token]).not_to be_present
      end

      it 'does not return a success response' do
        expect(generate).not_to be_success
      end
    end
  end
end
