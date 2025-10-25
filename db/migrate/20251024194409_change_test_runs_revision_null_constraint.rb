class ChangeTestRunsRevisionNullConstraint < ActiveRecord::Migration[8.0]
  def change
    change_column_null :test_runs, :revision, false
  end
end
