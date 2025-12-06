class User < ApplicationRecord
  validates :email_address, uniqueness: true
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :test_plans, dependent: :destroy
  has_many :test_runs, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
