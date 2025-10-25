class User < ApplicationRecord
  MAX_TEST_PLANS_PER_FREE_USER = 3

  UPGRADE_TO_PRO_MESSAGE = "You have reached the max. of #{MAX_TEST_PLANS_PER_FREE_USER} free test plans. <a href='https://testdb.gumroad.com/l/subscribe'>Upgrade</a> to Pro to continue.".html_safe

  validates :email_address, uniqueness: true
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :test_plans, dependent: :destroy
  has_many :test_runs, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def unlimited_test_plans?
    return true if admin?
    return true if paid_at.present?

    test_plans.count < MAX_TEST_PLANS_PER_FREE_USER
  end
end
