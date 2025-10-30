class TestPlan < ApplicationRecord
  belongs_to :user
  has_many :test_runs, dependent: :destroy

  validates :feature, :use_case, :steps_to_reproduce, presence: true
  validates :use_case, uniqueness: { scope: :feature }, allow_blank: true
  validate :user_has_unlimited_test_plans, on: :create

  def self.stats_for(user)
    all_test_plans = self.where(user: user).all
    test_plans_with_runs = all_test_plans.select { |it| it.last_run.present? }
    test_plans_with_successful_runs = test_plans_with_runs.select { |it| it.last_run.passed? }

    {
      total_test: all_test_plans.size,
      execution_rate: test_plans_with_runs.any? ? (test_plans_with_runs.size.to_f / all_test_plans.size) * 100 : 0,
      success_rate: test_plans_with_successful_runs.any? ? (test_plans_with_successful_runs.size.to_f / test_plans_with_runs.size) * 100 : 0
    }
  end

  def steps_to_reproduce_list
    return [] if steps_to_reproduce.blank?

    @steps_to_reproduce_list ||= steps_to_reproduce.tr("\r", "\n").tr("\n\n", "\n").split("\n").map do |line|
      line.strip.squish.presence
    end.select(&:present?)
  end

  def last_run
    @last_run ||= test_runs.last
  end

  def success_rate
    return 0 if test_runs.count.zero?

    (test_runs.count(&:passed?).to_f / test_runs.count) * 100
  end

  private

  def user_has_unlimited_test_plans
    return if user&.unlimited_test_plans?

    errors.add(:base, User::UPGRADE_TO_PRO_MESSAGE)
  end
end
