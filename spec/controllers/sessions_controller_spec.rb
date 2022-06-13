# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    let(:email) { 'test@test.com' }
    let(:password) { '123123' }

    before do
      create(:user, email: email, password: password)
      post :create, params: params
    end

    context 'when credentials are valid' do
      let(:params) do
        {
          email: email,
          password: password
        }
      end

      it 'returns a :created response' do
        expect(response).to have_http_status(:created)
      end

      it 'returns a valid token' do
        expect(json_response[:token]).to be_present
      end
    end

    context 'when credentials are not valid' do
      let(:params) do
        {
          email: 'aaa@aaa.com',
          password: '111'
        }
      end

      it 'returns a :unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when email is missing' do
      let(:params) do
        {
          password: '111'
        }
      end

      it 'returns a :unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when password is missing' do
      let(:params) do
        {
          email: 'aaa@aaa.com'
        }
      end

      it 'returns a :unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when both credentials are missing' do
      let(:params) do
        {}
      end

      it 'returns a :unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
