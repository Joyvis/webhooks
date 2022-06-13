# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Test User' }
    username { 'test_username' }
    email { 'test@test.com' }
    password { '123123' }
  end
end
