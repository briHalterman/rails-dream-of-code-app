# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Style/Documentation
  has_secure_password
  validates :role, presence: true
  validates :role, inclusion: { in: %w[admin mentor student] }
end
