# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject(:user) { create(:user) }

    it 'validates presence of email' do
      expect(user).to validate_presence_of(:email)
    end

    it 'validates presence of password' do
      expect(user).to validate_presence_of(:password)
    end

    it 'validates uniqueness of email' do
      expect(user).to validate_uniqueness_of(:email)
    end
  end
end
