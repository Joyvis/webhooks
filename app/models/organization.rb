# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects

  validates :name, presence: true
end
