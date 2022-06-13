# frozen_string_literal: true

# model that contains data about the users, also used to authenticate a user
class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  validates :email, :password, presence: true
  validates :email, uniqueness: true
end
