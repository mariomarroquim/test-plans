class TestRun < ApplicationRecord
  belongs_to :user
  belongs_to :test_plan

  validates :revision, presence: true
end
